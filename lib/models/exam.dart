class Exam {
  final String examId;
  final String classId;
  final String name;
  final String content;
  final String subjectId;
  final DateTime startTime;
  final DateTime endTime;
  final int duration;

  Exam({
    required this.examId,
    required this.classId,
    required this.name,
    required this.content,
    required this.subjectId,
    required this.startTime,
    required this.endTime,
    required this.duration,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      examId: json['examId'],
      classId: json['classId'],
      name: json['name'],
      content: json['content'],
      subjectId: json['subjectId'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'examId': examId,
      'classId': classId,
      'name': name,
      'content': content,
      'subjectId': subjectId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'duration': duration,
    };
  }
}
