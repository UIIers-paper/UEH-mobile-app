import 'dart:async';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class WorkmanagerService {
  static const String fetchExamTask = "fetchExamTask";

  static Future<void> init() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await _initBackgroundService();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      await _initWorkmanager();
    }

    print("[WorkmanagerService] Initialized.");
  }

  static Future<void> _initBackgroundService() async {
    final service = FlutterBackgroundService();

    await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onBackground: _iosBackgroundFetch,
        onForeground: _iosForegroundFetch,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: _androidBackgroundFetch,
        autoStart: true,
        isForegroundMode: false,
      ),
    );

    service.startService();
  }

  static Future<void> _initWorkmanager() async {
    await Workmanager().initialize(_callbackDispatcher, isInDebugMode: true);
    Workmanager().registerPeriodicTask(
      "2",
      fetchExamTask,
      frequency: Duration(minutes: 15),
      initialDelay: Duration(seconds: 10),
    );
  }

  static Future<void> _fetchExamData() async {
    try {
      var response = await http.get(Uri.parse("https://your-server.com/api/get-exam"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        print("[WorkmanagerService] Đã lấy đề thi: ${data}");
      } else {
        print("[WorkmanagerService] Lỗi khi lấy đề thi: ${response.statusCode}");
      }
    } catch (e) {
      print("[WorkmanagerService] Lỗi kết nối: $e");
    }
  }

  static void _androidBackgroundFetch(ServiceInstance service) async {
    print("[WorkmanagerService] Android Background Fetch Running...");
    await _fetchExamData();
  }

  static void _iosForegroundFetch(ServiceInstance service) {
    print("[WorkmanagerService] iOS Foreground Fetch Running...");
    _fetchExamData();
  }

  static Future<bool> _iosBackgroundFetch(ServiceInstance service) async {
    print("[WorkmanagerService] iOS Background Fetch Triggered...");
    await _fetchExamData();
    return true;
  }

  static void _callbackDispatcher() {
    Workmanager().executeTask((task, inputData) async {
      print("[WorkmanagerService] WorkManager Task Triggered: $task");
      await _fetchExamData();
      return Future.value(true);
    });
  }
}
