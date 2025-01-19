import 'package:flutter/material.dart';

class BottomAnswerWidget extends StatefulWidget {
  final int numberOfQuestions;
  int currentQuestionIndex;
  String selectedAnswer;
  final Function(String?) onAnswerChanged;
  final VoidCallback onClose;

  BottomAnswerWidget({
    required this.numberOfQuestions,
    required this.currentQuestionIndex,
    required this.selectedAnswer,
    required this.onAnswerChanged,
    required this.onClose,
  });

  @override
  _BottomAnswerWidgetState createState() => _BottomAnswerWidgetState();
}

class _BottomAnswerWidgetState extends State<BottomAnswerWidget> {
  final int questionsPerPage = 5;

  // Hàm này giúp lấy số lượng câu hỏi trên trang hiện tại
  int _getStartIndexForPage() {
    return (widget.currentQuestionIndex ~/ questionsPerPage) * questionsPerPage;
  }

  // Hàm lấy các câu hỏi cho trang hiện tại
  List<String> _getCurrentPageQuestions() {
    int startIndex = _getStartIndexForPage();
    int endIndex = startIndex + questionsPerPage;
    List<String> questions = [];
    for (int i = startIndex; i < endIndex && i < widget.numberOfQuestions; i++) {
      questions.add('Câu hỏi ${i + 1}');
    }
    return questions;
  }

  void _nextPage() {
    if (widget.currentQuestionIndex < widget.numberOfQuestions - questionsPerPage) {
      setState(() {
        widget.currentQuestionIndex += questionsPerPage;
        widget.selectedAnswer = "";
      });
    }
  }

  void _previousPage() {
    if (widget.currentQuestionIndex > 0) {
      setState(() {
        widget.currentQuestionIndex -= questionsPerPage;
        widget.selectedAnswer = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> currentPageQuestions = _getCurrentPageQuestions();
    return FractionallySizedBox(
      heightFactor: 0.4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Trang ${widget.currentQuestionIndex ~/ questionsPerPage + 1}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  // Hiển thị câu hỏi theo hàng ngang
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      for (int i = 0; i < currentPageQuestions.length; i++)
                        Column(
                          children: [
                            Text(
                              currentPageQuestions[i],
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            // Các câu trả lời
                            for (String option in ['A', 'B', 'C', 'D'])
                              RadioListTile<String>(
                                title: Text("$option. Đáp án $option"),
                                value: option,
                                groupValue: widget.selectedAnswer,
                                onChanged: widget.onAnswerChanged,
                              ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: widget.currentQuestionIndex > 0 ? _previousPage : null,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: (widget.currentQuestionIndex + questionsPerPage) < widget.numberOfQuestions ? _nextPage : null,
                ),
                IconButton(
                  icon: Icon(Icons.flag),
                  onPressed: () {
                    print("Câu hỏi ${widget.currentQuestionIndex + 1} đã được đánh dấu.");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
