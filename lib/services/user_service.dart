import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:device_info/device_info.dart';

import 'dart:io';

class UserService {
  Future<String?> getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user?.uid;
  }

  Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    late String deviceId;
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.androidId;
    } else {
      deviceId = 'null';
    }
    return deviceId;
  }

  Future<void> saveUserInfo() async {
    try {
      String? userId = await getUserId();
      String deviceId = await getDeviceId();
      DateTime loginTime = DateTime.now();

      if (userId != null) {
        await FirebaseFirestore.instance.collection('user_logs').add({
          'user_id': userId,
          'device_id': deviceId,
          'login_time': loginTime.toIso8601String(),
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
        });
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
      final docRef = FirebaseFirestore.instance.collection('exam_violations').doc(userId);
      await docRef.set({
        'user_id': userId,
        'violations': {
          violationType: FieldValue.increment(1),
        },
      }, SetOptions(merge: true));

      print("Đã ghi nhận lỗi: $violationType");
    } catch (e) {
      print("Lỗi khi ghi nhận vi phạm: $e");
    }
  }
}
