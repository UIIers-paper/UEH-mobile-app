import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:mobile_device_identifier/mobile_device_identifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ueh_mobile_app/database/local_database.dart';
import 'dart:io';

class UserService {
  Future<String?> getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<String?> getDeviceId() async {
    try {
      final String? deviceId = await MobileDeviceIdentifier().getDeviceId();
      print("Device ID: $deviceId");
      return deviceId;
    } catch (e) {
      print("Error fetching Device ID: $e");
    }

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
      String? deviceId = await getDeviceId();
      DateTime loginTime = DateTime.now();

      if (userId != null) {
        Map<String, dynamic> deviceData = await getDeviceInformation();
        String logId = DateTime.now().millisecondsSinceEpoch.toString();
        await saveLogId(logId);
        print("Log ID: $logId");
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
        print(deviceId);
        print("Thông tin người dùng đã được lưu!");
      } else {
        print("Người dùng chưa đăng nhập.");
      }
    } catch (e) {
      print("Lỗi khi lưu thông tin người dùng: $e");
    }
  }


  Future<void> recordViolation(String violationType) async {
    try {
      String? userId = await getUserId();
      if (userId == null) return;
      final localDb = LocalDatabase();
      await localDb.insertLog(userId, violationType);
      print("Log đã được ghi cục bộ: $violationType");
    } catch (e) {
      print("Lỗi khi ghi log cục bộ: $e");
    }
  }


  Future<void> syncLogsToFirebase() async {
    try {
      final localDb = LocalDatabase();
      List<Map<String, dynamic>> unsyncedLogs = await localDb.getUnsyncedLogs();

      if (unsyncedLogs.isEmpty) {
        print("Không có log nào cần đồng bộ.");
        return;
      }

      List<int> syncedLogIds = [];
      for (var log in unsyncedLogs) {
        try {
          await FirebaseFirestore.instance.collection('exam_violations').add({
            'user_id': log['user_id'],
            'violation_type': log['violation_type'],
            'timestamp': log['timestamp'],
          });
          syncedLogIds.add(log['id']);
        } catch (e) {
          print("Lỗi khi đồng bộ log: $e");
        }
      }

      if (syncedLogIds.isNotEmpty) {
        await localDb.markLogsAsSynced(syncedLogIds);
        print("Đồng bộ thành công: ${syncedLogIds.length} log.");
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
