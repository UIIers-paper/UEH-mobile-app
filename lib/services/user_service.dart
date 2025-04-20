import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ueh_mobile_app/database/local_database.dart';
import 'dart:io';
import 'dart:convert';

class UserService {
  Future<String?> getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }


  Future <Map<String, dynamic>> getDeviceInformation() async {
    var deviceInfo = DeviceInfoPlugin();
    late var data;
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      data=_readIosDeviceInfo(iosDeviceInfo);
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      data= _readAndroidBuildData(androidDeviceInfo);
    } else {
      data = 'null';
    }
    return data;
  }

  Future<void> logUserInfo() async {
    try {
      String? userId = await getUserId();
      String? deviceId = await MobileDeviceIdentifier().getDeviceId();
      DateTime loginTime = DateTime.now();

      if (userId != null) {
        Map<String, dynamic> deviceData = await getDeviceInformation();
        String logId = DateTime.now().millisecondsSinceEpoch.toString();
        await saveLogId(logId);
        // print("Log ID: $logId");
        await FirebaseFirestore.instance.collection('user_logs').doc(logId).set({
          'log_id': logId,
          'user_id': userId,
          'device_id': deviceId,
          'login_time': loginTime.toIso8601String(),
          'logout_time': null,
          'device_info': {
            'device_id': deviceId,
            'platform': Platform.isAndroid ? 'Android' : 'iOS',
            'model': deviceData['model'],
            'hardware': deviceData['hardware'],
            'os_version': Platform.isAndroid ? deviceData['version.release'] : deviceData['systemVersion'],
            'sdk_version': Platform.isAndroid ? deviceData['version.sdkInt'] : null,
            'is_physical_device': deviceData['isPhysicalDevice'],
          }
        });
        // print(deviceId);
        // print("Thông tin người dùng đã được lưu!");
      } else {
        print("Người dùng chưa đăng nhập.");
      }
    } catch (e) {
      print("Lỗi khi lưu thông tin người dùng: $e");
    }
  }


  Future<void> recordViolation(String violationType, String examId) async {
    try {
      String? userId = await getUserId();
      if (userId == null) return;
      final localDb = LocalDatabase();
      await localDb.insertLog(userId, violationType, examId);
      // print("Log đã được ghi cục bộ: $violationType");
    } catch (e) {
      print("Lỗi khi ghi log cục bộ: $e");
    }
  }

  Future<void> recordAnswer(String examId, int questionIndex, String answer) async {
    try {
      String? userId = await getUserId();
      if (userId == null) return;
      final localDb = LocalDatabase();
      print("Log đã được ghi cục bộ: $examId, $questionIndex, $answer");
      await localDb.saveAnswer(examId, questionIndex, answer);
    } catch (e) {
      print("Lỗi khi ghi log cục bộ: $e");
    }
  }



  Future<void> syncLogsToFirebase() async {
    try {
      final syncedLogIds = <int>[];
      final syncedExamIds = <String>[];
      final localDb = LocalDatabase();
      String? userId = await getUserId();
      final firestore = FirebaseFirestore.instance;
      print('Đang đồng bộ hóa log lên Firebase...');
      List<Map<String, dynamic>> unsyncedLogs = await localDb.getUnsyncedLogs();
      List<Map<String, dynamic>> examAnswers = await localDb.getUnsyncedAnswers(userId);
      print("Số lượng log chưa đồng bộ: ${unsyncedLogs.length}");
      print("Số lượng câu trả lời chưa đồng bộ: ${examAnswers.length}");
      if (unsyncedLogs.isEmpty && examAnswers.isEmpty) {
        print("Không có log nào cần đồng bộ.");
        return;
      }


      for (var log in unsyncedLogs) {
        try {
          await firestore.collection('exam_violations').add({
            'user_id': log['user_id'],
            'violation_type': log['violation_type'],
            'timestamp': log['timestamp'],
          });
          syncedLogIds.add(log['id']);
        } catch (e) {
          print("Lỗi khi đồng bộ log: $e");
        }
      }
      for (var answerEntry in examAnswers) {
        try {
          print("Đang đồng bộ hóa câu trả lời lên Firebase... $answerEntry" );
          await firestore.collection('exam').add({
            'exam_id': answerEntry['exam_id'],
            'student_id': answerEntry['user_id'],
            'answer': answerEntry['answers'],
          });
          syncedExamIds.add(answerEntry['exam_id']);
          print("Đã đồng bộ câu trả lời cho exam_id: ${answerEntry['exam_id']}");
        } catch (e) {
          print("Lỗi khi đồng bộ câu trả lời: $e");
        }
      }
      if (syncedLogIds.isNotEmpty) {
        await localDb.markLogsAsSynced(syncedLogIds);
      }

      if (syncedExamIds.isNotEmpty) {
        await localDb.markAnswersAsSynced(syncedExamIds);
      }
    } catch (e) {
      print("Lỗi khi đồng bộ log: $e");
    }
  }


  
  Future<void> updateLogoutTime() async {
    try {
      String? logId = await getLogId();
      if (logId == null) {
        print("logId không tồn tại");
        return;
      }
      DateTime logoutTime = DateTime.now();
      
      await FirebaseFirestore.instance.collection('user_logs').doc(logId).update({
        'logout_time': logoutTime.toIso8601String(),
      });
      print("Logout time updated successfully.");
    } catch (e) {
      print("Error updating logout time: $e");
    }
  }

  Future<void> saveLogId(String logId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('logId', logId);
  }

  Future<String?> getLogId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('logId');
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'serialNumber': build.serialNumber,
      'isLowRamDevice': build.isLowRamDevice,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'modelName': data.modelName,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'isiOSAppOnMac': data.isiOSAppOnMac,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
