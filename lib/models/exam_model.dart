class ExamModel {
  final int id;
  final String examCode;
  final String displayName;
  final String room;
  final DateTime examDateTime;
  final String date;
  final String examName;
  final int timeLimit;
  final DateTime? startAt;
  final DateTime? finishAt;
  final int status;
  bool isSaved;

  ExamModel({
    required this.id,
    required this.examCode,
    required this.displayName,
    required this.room,
    required this.examDateTime,
    required this.date,
    required this.examName,
    required this.timeLimit,
    this.startAt,
    this.finishAt,
    required this.status,
    this.isSaved = false,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    final ttCaThi = json['ttCaThi'] ?? {};
    final ttDeThi = json['ttDeThi'] ?? {};
    final DateTime examDateTime = DateTime.parse(ttCaThi['ngayGioBatDau']);

    final String formattedDate = "${examDateTime.day.toString().padLeft(2, '0')}/"
        "${examDateTime.month.toString().padLeft(2, '0')}/"
        "${examDateTime.year}";

    return ExamModel(
      id: json['id'] as int,
      examCode: ttCaThi['maCaThi'] ?? '',
      displayName: ttCaThi['tenHienThi'] ?? '',
      room: ttCaThi['phongThi'] ?? '',
      examDateTime: examDateTime,
      date: formattedDate,
      examName: ttDeThi['name'] ?? '',
      timeLimit: ttDeThi['timeLimit'] ?? 0,
      startAt: json['startAt'] != null ? DateTime.tryParse(json['startAt']) : null,
      finishAt: json['finishAt'] != null ? DateTime.tryParse(json['finishAt']) : null,
      status: json['status'] ?? 0,
    );
  }


  static List<ExamModel> examModelFromJson(List<dynamic> jsonList) {
    return jsonList
        .whereType<Map<String, dynamic>>()
        .map((json) => ExamModel.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'examCode': examCode,
      'displayName': displayName,
      'room': room,
      'examDateTime': examDateTime.toIso8601String(),
      'examName': examName,
      'timeLimit': timeLimit,
      'startAt': startAt?.toIso8601String(),
      'finishAt': finishAt?.toIso8601String(),
      'status': status,
      'isSaved': isSaved,
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