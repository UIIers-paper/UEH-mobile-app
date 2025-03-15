class ExamModel {
  String examId;
  String teacherName;
  String courseName;
  String subject;
  DateTime dateTime;
  String startTime;
  String endTime;
  int questionNumbers;
  int limitTime;
  String date;
  int duration;
  String? content;
  bool isSaved = false;

  ExamModel({
    required this.examId,
    required this.teacherName,
    required this.courseName,
    required this.subject,
    required this.dateTime,
    required this.startTime,
    required this.endTime,
    required this.questionNumbers,
    required this.limitTime,
    required this.date,
    required this.duration,
    this.content,
    this.isSaved = false,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      examId: json['examId'],
      teacherName: json['teacherName'],
      courseName: json['courseName'],
      subject: json['subject'],
      dateTime: DateTime.tryParse(json['dateTime'])!,
      startTime: json['startTime'],
      endTime: json['endTime'],
      questionNumbers: json['questionNumbers'],
      limitTime: json['limitTime'],
      date: json['date'],
      duration: json['duration'],
      content: json['content'] as String?,
    );
  }

  static List<ExamModel> examModelFromJson(List<dynamic> jsonList) {
    return jsonList
        .where((json) => json is Map<String, dynamic>)
        .map((json) => ExamModel.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'examId': examId,
      'teacherName': teacherName,
      'courseName': courseName,
      'subject': subject,
      'dateTime': dateTime.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'questionNumbers': questionNumbers,
      'limitTime': limitTime,
      'date': date,
      'duration': duration,
      'content': content ?? '',
    };
  }
}

