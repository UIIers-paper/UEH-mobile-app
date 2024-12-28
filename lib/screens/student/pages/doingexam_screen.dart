import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ueh_mobile_app/services/network_service.dart';
import 'package:webview_flutter/webview_flutter.dart';
class DoingExamScreen extends StatefulWidget {
  @override
  _DoingExamScreenState createState() => _DoingExamScreenState();
}

class _DoingExamScreenState extends State<DoingExamScreen> with WidgetsBindingObserver {
  final NetworkService networkService = NetworkService();
  late WebViewController controller;
  bool isLoading = true;
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
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true; // Bắt đầu tải
            });
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false; // Tải xong
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://www.eurekalert.org/'),
      );
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
    if (isLoading){
      return Center(
        child: CircularProgressIndicator(
          color: Colors.blueAccent,
          strokeWidth: 10.0,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Đề Thi"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: WebViewWidget(controller: controller),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Câu hỏi: Lựa chọn đáp án đúng",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        RadioListTile<String>(
                          title: Text("A. Đáp án A"),
                          value: "A",
                          groupValue: "selectedAnswer", 
                          onChanged: (value) {
                          },
                        ),
                        RadioListTile<String>(
                          title: Text("B. Đáp án B"),
                          value: "B",
                          groupValue: "selectedAnswer",
                          onChanged: (value) {
                          },
                        ),
                        RadioListTile<String>(
                          title: Text("C. Đáp án C"),
                          value: "C",
                          groupValue: "selectedAnswer",
                          onChanged: (value) {
                          },
                        ),
                        RadioListTile<String>(
                          title: Text("D. Đáp án D"),
                          value: "D",
                          groupValue: "selectedAnswer",
                          onChanged: (value) {
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
