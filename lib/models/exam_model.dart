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
    this.isSaved = false,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
  return ExamModel(
    examId: json['examId'] as String,
    teacherName: json['teacherName'] as String,
    courseName: json['courseName'] as String,
    subject: json['subject'] as String,
    dateTime: DateTime.tryParse(json['datetime'] as String)!,
    startTime: json['startTime'] as String,
    endTime: json['endTime'] as String,
    questionNumbers: json['questionNumbers'] as int,
    limitTime: json['limitTime'] as int,
    date: json['date'] as String,
    duration: json['duration'] as int,
    isSaved: json['isSaved'] as bool? ?? false,
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
    };
  }
}

class ExamContentModel {
  final String examId;
  final String? content;

  ExamContentModel({
    required this.examId,
    this.content,
  });

  factory ExamContentModel.fromJson(Map<String, dynamic> json) {
    return ExamContentModel(
      examId: json['id'] as String,
      content: json['content'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': examId,
      'content': content ?? '',
    };
  }
}