class ExamList {
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

  ExamList({
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

  factory ExamList.fromJson(Map<String, dynamic> json) {
    return ExamList(
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

  static List<ExamList> examListFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => ExamList.fromJson(json)).toList();
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
      'duration': duration
    };
  }
}

class ExamItem {
  DateTime datetime;
  String content;

  ExamItem({
    required this.datetime,
    required this.content,
  });

  factory ExamItem.fromJson(Map<String, dynamic> json) {
    return ExamItem(
      datetime: json['datetime'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime,
      'content': content,
    };
  }
}