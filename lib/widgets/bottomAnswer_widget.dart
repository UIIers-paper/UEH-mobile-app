import 'package:flutter/material.dart';

class BottomAnswerWidget extends StatefulWidget {
  final int currentQuestionIndex;
  final String selectedAnswer;
  final Function(String?) onAnswerChanged;
  final VoidCallback onClose;
  final int numberOfQuestions;
  final VoidCallback onFinish;

  const BottomAnswerWidget({
    Key? key,
    required this.currentQuestionIndex,
    required this.selectedAnswer,
    required this.onAnswerChanged,
    required this.onClose,
    required this.numberOfQuestions,
    required this.onFinish,
  }) : super(key: key);

  @override
  _BottomAnswerWidgetState createState() => _BottomAnswerWidgetState();
}

class _BottomAnswerWidgetState extends State<BottomAnswerWidget> {
  final int questionsPerPage = 5;
  int currentPage = 0;
  int get totalPages => (widget.numberOfQuestions / questionsPerPage).ceil();

  List<int> getCurrentPageQuestions() {
    int start = currentPage * questionsPerPage;
    int end = start + questionsPerPage;
    return List.generate(
        end > widget.numberOfQuestions ? widget.numberOfQuestions - start : questionsPerPage,
            (index) => start + index + 1);
  }

  @override
  Widget build(BuildContext context) {
    List<int> currentPageQuestions = getCurrentPageQuestions();

    return FractionallySizedBox(
      heightFactor: 0.4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(16.0),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, color: Colors.redAccent),
                onPressed: widget.onClose,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: currentPageQuestions.map((questionNumber) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Câu $questionNumber",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    for (String option in ['A', 'B', 'C', 'D'])
                      Row(
                        children: [
                          Text(option, style: const TextStyle(fontSize: 14)),
                          Radio<String>(
                            value: option,
                            groupValue: widget.selectedAnswer,
                            onChanged: widget.onAnswerChanged,
                          ),
                        ],
                      ),
                  ],
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: currentPage > 0
                      ? () {
                    setState(() {
                      currentPage--;
                    });
                  }
                      : null,
                ),
                Text(
                  "${currentPage + 1} / $totalPages",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                currentPage < totalPages - 1
                    ? IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      currentPage++;
                    });
                  },
                )
                    : ElevatedButton(
                  onPressed: widget.onFinish,
                  child: Text("Finish"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
