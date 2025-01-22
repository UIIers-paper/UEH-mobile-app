import 'package:flutter/material.dart';
// import 'package:flutter/foundation.dart'; // Import UniqueKey
import 'package:ueh_mobile_app/widgets/bottom_answer_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ueh_mobile_app/services/network_service.dart';
import 'package:ueh_mobile_app/widgets/local_exam.dart';
import 'package:ueh_mobile_app/services/user_service.dart';
class DoingExamScreen extends StatefulWidget {
  final VoidCallback onFinish;

  DoingExamScreen({required this.onFinish});
  @override
  _DoingExamScreenState createState() => _DoingExamScreenState();
}

class _DoingExamScreenState extends State<DoingExamScreen> with WidgetsBindingObserver {
  final NetworkService networkService = NetworkService();
  final UserService _userLog = UserService();
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
        _userLog.recordViolation("network");
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lockExam();
      _userLog.recordViolation("app_paused");
    }
  }

  void _lockExam() {
    print("vi phạm");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bạn đã vi phạm quy chế thi'),
        backgroundColor: Colors.red,
      ),
    );
    // Navigator.pushReplacementNamed(context, '/error');
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
          numberOfQuestions: 40,
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
          onFinish: widget.onFinish,
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