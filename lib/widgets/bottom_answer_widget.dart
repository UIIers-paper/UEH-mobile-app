import 'package:flutter/material.dart';

class BottomAnswerWidget extends StatefulWidget {
  final List<String> questions;
  int currentQuestionIndex;
  String selectedAnswer;
  final Function(String?) onAnswerChanged;
  final VoidCallback onClose;

  BottomAnswerWidget({
    required this.questions,
    required this.currentQuestionIndex,
    required this.selectedAnswer,
    required this.onAnswerChanged,
    required this.onClose,
  });

  @override
  _BottomAnswerWidgetState createState() => _BottomAnswerWidgetState();
}

class _BottomAnswerWidgetState extends State<BottomAnswerWidget> {


  void _nextQuestion() {
    if (widget.currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        widget.currentQuestionIndex++;
        widget.selectedAnswer = "";
      });
    }
  }

  void _previousQuestion() {
    if (widget.currentQuestionIndex > 0) {
      setState(() {
        widget.currentQuestionIndex--;
        widget.selectedAnswer = "";
      });
    }
  }

  void _flagQuestion() {
    print("Câu hỏi ${widget.currentQuestionIndex + 1} đã được đánh dấu.");
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.questions[widget.currentQuestionIndex]}",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: widget.onClose,
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  RadioListTile<String>(
                    title: Text("A. Đáp án A"),
                    value: "A",
                    groupValue: widget.selectedAnswer,
                    onChanged: widget.onAnswerChanged,
                  ),
                  RadioListTile<String>(
                    title: Text("B. Đáp án B"),
                    value: "B",
                    groupValue: widget.selectedAnswer,
                    onChanged: widget.onAnswerChanged,
                  ),
                  RadioListTile<String>(
                    title: Text("C. Đáp án C"),
                    value: "C",
                    groupValue: widget.selectedAnswer,
                    onChanged: widget.onAnswerChanged,
                  ),
                  RadioListTile<String>(
                    title: Text("D. Đáp án D"),
                    value: "D",
                    groupValue: widget.selectedAnswer,
                    onChanged: widget.onAnswerChanged,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => _previousQuestion(),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () => _nextQuestion(),
                ),
                IconButton(
                  icon: Icon(Icons.flag),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
