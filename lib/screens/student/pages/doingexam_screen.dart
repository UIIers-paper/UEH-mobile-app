import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ueh_mobile_app/services/network_service.dart';

class DoingExamScreen extends StatefulWidget {
  @override
  _DoingExamScreenState createState() => _DoingExamScreenState();
}

class _DoingExamScreenState extends State<DoingExamScreen> with WidgetsBindingObserver {
  final NetworkService networkService = NetworkService();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    networkService.monitorNetwork().listen((ConnectivityResult result) {
      print("Current connectivity result: $result");
      if (result != ConnectivityResult.none) {
        _lockExam();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("App lifecycle state changed: $state");
    if (state == AppLifecycleState.paused) {
      _lockExam();
    }
  }

  void _lockExam() {
    print("Bài thi đã bị khóa!");
    Navigator.pushReplacementNamed(context, '/error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Đang làm bài thi",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(), // Biểu tượng tải
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Hủy đăng ký observer khi widget bị xóa
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
