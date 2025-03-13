class ExamModel {
  String examId;
  String teacherName;
  String courseName;
  String subject;
  String startTime;
  String endTime;
  int questionNumbers;
  int limitTime;
  String date;
  int duration;
  String content;

  ExamModel({
    required this.examId,
    required this.teacherName,
    required this.courseName,
    required this.subject,
    required this.startTime,
    required this.endTime,
    required this.questionNumbers,
    required this.limitTime,
    required this.date,
    required this.duration,
    required this.content,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      examId: json['examId'],
      teacherName: json['teacherName'],
      courseName: json['courseName'],
      subject: json['subject'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      questionNumbers: json['questionNumbers'],
      limitTime: json['limitTime'],
      date: json['date'],
      duration: json['duration'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'examId': examId,
      'teacherName': teacherName,
      'courseName': courseName,
      'subject': subject,
      'startTime': startTime,
      'endTime': endTime,
      'questionNumbers': questionNumbers,
      'limitTime': limitTime,
      'date': date,
      'duration': duration,
      'content': content,
    };
  }
}