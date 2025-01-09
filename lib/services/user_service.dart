import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:device_info/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';

import 'dart:io';

class UserService {
  Future<String?> getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    late String? deviceId;
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
      print(iosDeviceInfo);
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // print(androidDeviceInfo);
      deviceId = androidDeviceInfo.id;
      print(deviceId);
    } else {
      deviceId = 'null';
    }
    return deviceId;
  }
  Future <Map<String, dynamic>> DeviceTestinginfo() async {
    var deviceInfo = DeviceInfoPlugin();
    late String? deviceId;
    late var data;
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
      print(iosDeviceInfo);
      data=_readIosDeviceInfo(iosDeviceInfo);
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // print(androidDeviceInfo);
      // deviceId = androidDeviceInfo.id;
      data= _readAndroidBuildData(androidDeviceInfo);
    } else {
      deviceId = 'null';
    }
    return data;
  }

  Future<void> saveUserInfo() async {
    try {
      String? userId = await getUserId();
      String? deviceId = await getDeviceId();
      DateTime loginTime = DateTime.now();

      if (userId != null) {
        String logId = DateTime.now().millisecondsSinceEpoch.toString();
        // await FirebaseFirestore.instance.collection('user_logs').add({
        //   'log_id': logId,
        //   'user_id': userId,
        //   'device_id': deviceId,
        //   'login_time': loginTime.toIso8601String(),
        //   'logout_time': null,
        //   'exam_ids': [],
        // });
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
      String examId = DateTime.now().millisecondsSinceEpoch.toString();
      final docRef = FirebaseFirestore.instance.collection('exam_violations').doc(userId);
      // await docRef.set({
      //   'exam_id': examId,
      //   'user_id': userId,
      //   'violations': {
      //     violationType: FieldValue.increment(1),
      //   },
      // }, SetOptions(merge: true));
      //
      // final userLogsRef = FirebaseFirestore.instance
      //     .collection('user_logs')
      //     .where('user_id', isEqualTo: userId)
      //     .orderBy('login_time', descending: true)
      //     .limit(1);
      // final snapshot = await userLogsRef.get();

      // if (snapshot.docs.isNotEmpty) {
      //   var logDoc = snapshot.docs.first;
      //   await logDoc.reference.update({
      //     'exam_ids': FieldValue.arrayUnion([examId]),
      //   });
      // }

      print("Đã ghi nhận lỗi: $violationType");
    } catch (e) {
      print("Lỗi khi ghi nhận vi phạm: $e");
    }
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
