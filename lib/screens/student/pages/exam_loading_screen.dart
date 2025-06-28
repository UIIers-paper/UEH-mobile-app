import 'package:flutter/material.dart';
import 'package:ueh_mobile_app/models/exam_model.dart';
import 'package:ueh_mobile_app/screens/student/pages/exam_screen.dart';
import 'package:ueh_mobile_app/services/api_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ueh_mobile_app/database/local_database.dart';
import 'package:ueh_mobile_app/services/examstorage_service.dart';
class ExamLoadingScreen extends StatefulWidget {
  final int examId;
  final Map<String, dynamic> examData;

  const ExamLoadingScreen({
    Key? key,
    required this.examId,
    required this.examData,
  }) : super(key: key);


  @override
  _ExamLoadingScreenState createState() => _ExamLoadingScreenState();
}

class _ExamLoadingScreenState extends State<ExamLoadingScreen> with SingleTickerProviderStateMixin {
  final LocalDatabase _db = LocalDatabase();
  final ExamStorage _examStorage = ExamStorage();
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _prepareExam(widget.examData);

  }

  Future<void> _prepareExam(Map<String, dynamic> examData) async {
    try {
      final String content = examData['content'];

      // Lưu mã hoá đề thi
      // final encrypted = await _examStorage.saveEncryptedExam(widget.examId.toString(), content);
      await _db.saveEncryptedFile(widget.examId.toString(), content);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>   ExamScreen(),
              settings: RouteSettings(arguments: widget.examId.toString()),
            ),
          );
        }
      });


    } catch (e) {
      print('Lỗi xử lý đề thi: $e');
      setState(() => _isLoading = false);
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _isLoading
            ? RotationTransition(
                turns: _animation,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.square,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              )
            : const Text(
                "Đề thi đã tải xong, đang chuyển trang...",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
