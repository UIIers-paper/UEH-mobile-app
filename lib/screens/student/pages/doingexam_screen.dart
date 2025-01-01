import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart'; // Import UniqueKey
import 'package:ueh_mobile_app/widgets/bottom_answer_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ueh_mobile_app/services/network_service.dart';
import 'package:ueh_mobile_app/widgets/local_exam.dart';

class DoingExamScreen extends StatefulWidget {
  @override
  _DoingExamScreenState createState() => _DoingExamScreenState();
}

class _DoingExamScreenState extends State<DoingExamScreen> with WidgetsBindingObserver {
  final NetworkService networkService = NetworkService();
  bool isBottomSheetOpen = false;
  int currentQuestionIndex = 0;
  final List<String> questions = ["Câu hỏi 1", "Câu hỏi 2", "Câu hỏi 3"];
  String selectedAnswer = "";

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

  void _toggleBottomSheet() {
    setState(() {
      isBottomSheetOpen = !isBottomSheetOpen;
    });

    if (isBottomSheetOpen) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => BottomAnswerWidget(
          questions: questions,
          currentQuestionIndex: currentQuestionIndex,
          selectedAnswer: selectedAnswer,
          onAnswerChanged: (value) {
            setState(() {
              selectedAnswer = value ?? "";
            });
          },
          onClose: () {
            setState(() {
              isBottomSheetOpen = false;
            });
            Navigator.pop(context);
          },
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đề Thi"),
      ),
      body: Stack(
        children: [
          LocalHtmlViewer(),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _toggleBottomSheet,
              child: Icon(isBottomSheetOpen ? Icons.close : Icons.edit),
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