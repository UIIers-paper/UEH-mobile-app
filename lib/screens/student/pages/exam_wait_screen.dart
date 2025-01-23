import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/providers/network_status_provider.dart';
import 'package:ueh_mobile_app/providers/airplane_status_provider.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ExamWaitScreen extends StatefulWidget {
  @override
  _ExamWaitScreenState createState() => _ExamWaitScreenState();
}

class _ExamWaitScreenState extends State<ExamWaitScreen> {
  final NetworkService networkService = NetworkService();
  final UserService _userService = UserService();
  // StreamSubscription<ConnectivityResult>? _subscription;
  bool isInternetConnected = true;
  int countdown = 5;
  bool isLoading = true;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isConnected = Provider.of<NetworkStatusProvider>(context, listen: true).isInternetConnected;
    if (isInternetConnected != isConnected) {
      isInternetConnected = isConnected;
      _monitorNetworkAndSyncLogs(isInternetConnected);
    }
  }

  void _monitorNetworkAndSyncLogs(bool isConnected) async {
    while (true) { 
      if (isConnected) {
        print("Wifi is enabled");
        print(isConnected);
        await _syncLogsToFirebase();
        break;
      } else {
          print("Wifi is disabled");
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Bạn cần bật wifi để hoàn tất nộp bài thi.'),
            backgroundColor: Colors.yellow,
          ),
        );
          final isConnected = Provider.of<NetworkStatusProvider>(context, listen: true).isInternetConnected;
          if (isInternetConnected != isConnected) {
            isInternetConnected = isConnected;
            await _syncLogsToFirebase();
          }
      }
    }
    
  }

  void _startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        timer.cancel();
        Navigator.pushNamed(context, AppRoutes.dashboardScreen);
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  Future<void> _syncLogsToFirebase() async {
    if (isLoading) {
      print("Syncing logs to Firebase...");
      await _userService.syncLogsToFirebase();
      print("Logs synchronized!");

      setState(() {
        isLoading = false;
      });

      _startCountdown();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exam Alert")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Redirecting to dashboard in $countdown seconds...",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
