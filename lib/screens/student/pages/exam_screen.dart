import 'package:flutter/material.dart';
import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:ueh_mobile_app/services/network_service.dart';
import 'package:ueh_mobile_app/screens/student/pages/doingexam_screen.dart';
import 'dart:async';
import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/providers/network_status_provider.dart';
import 'package:ueh_mobile_app/providers/airplane_status_provider.dart';

import 'package:provider/provider.dart';

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen>{
  final NetworkService networkService = NetworkService();


  void _doExercise(bool isInternetConnected) async {
    print("Doing exercise...");
    bool isAirplaneModeEnabled = await networkService.isAirplaneModeEnabled();
    print("Connection: ${await networkService.checkNetworkStatus()}");

  
    print(isInternetConnected);
    if (isInternetConnected || !isAirplaneModeEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bạn cần tắt Wi-Fi và bật chế độ máy bay để làm bài thi.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      print('thi');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DoingExamScreen(
            onFinish: _finishExercise,
          ),
        ),
      );
    }


  }

  void _finishExercise() async{
    print("Finish exercise...");
    Navigator.pushNamed(
      context,
      AppRoutes.waitingScreen,
    );

  }



  @override
  Widget build(BuildContext context) {
    final isConnected =
        context.watch<NetworkStatusProvider>().isInternetConnected;
    final isAirplaneModeEnabled = context.watch<AirplaneModeProvider>().isAirplaneModeEnabled;
    print("Airplane mode, $isAirplaneModeEnabled");
    print("Network, $isConnected");
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: ()=>_doExercise(isConnected),
          child: Text("Làm bài thi"),
        ),
      ),
    );
  }
}
