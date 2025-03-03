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
    };
  }
}