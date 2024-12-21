import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ueh_mobile_app/services/network_service.dart';
import 'package:ueh_mobile_app/screens/student/pages/doingexam_screen.dart';

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen>{
  final NetworkService networkService = NetworkService();

  @override
  void initState() {
    super.initState();
  }

  void _doExercise() async {
    print("Doing exercise...");
    bool isAirplaneModeEnabled = await networkService.isAirplaneModeEnabled();
    print("Airplane mode enabled: $isAirplaneModeEnabled");

    bool isWifiEnabled = await networkService.checkNetworkStatus();

    print("Wi-Fi enabled: $isWifiEnabled");

    if (isWifiEnabled && !isAirplaneModeEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bạn cần tắt Wi-Fi và bật chế độ máy bay để làm bài thi.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoingExamScreen(),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _doExercise,
          child: Text("Làm bài thi"),
        ),
      ),
    );
  }
}
