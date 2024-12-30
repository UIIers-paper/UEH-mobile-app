import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ueh_mobile_app/services/network_service.dart';
import 'package:ueh_mobile_app/widgets/local_exam.dart';

class DoingExamScreen extends StatefulWidget {
  @override
  _DoingExamScreenState createState() => _DoingExamScreenState();
}

class _DoingExamScreenState extends State<DoingExamScreen> with WidgetsBindingObserver {
  final NetworkService networkService = NetworkService();
  int currentQuestionIndex = 0;
  final List<String> questions = ["Câu hỏi 1", "Câu hỏi 2", "Câu hỏi 3"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    networkService.monitorNetwork().listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        _lockExam();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lockExam();
    }
  }

  void _lockExam() {
    Navigator.pushReplacementNamed(context, '/error');
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void _flagQuestion() {
    print("Câu hỏi ${currentQuestionIndex + 1} đã được đánh dấu.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đề Thi"),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: LocalHtmlViewer(),
          ),
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${questions[currentQuestionIndex]}",
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
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text("B. Đáp án B"),
                          value: "B",
                          groupValue: "selectedAnswer",
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text("C. Đáp án C"),
                          value: "C",
                          groupValue: "selectedAnswer",
                          onChanged: (value) {},
                        ),
                        RadioListTile<String>(
                          title: Text("D. Đáp án D"),
                          value: "D",
                          groupValue: "selectedAnswer",
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: _previousQuestion,
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: _nextQuestion,
                      ),
                      IconButton(
                        icon: Icon(Icons.flag),
                        onPressed: _flagQuestion,
                      ),
                    ],
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
