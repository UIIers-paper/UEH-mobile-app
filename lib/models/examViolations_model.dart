class ExamViolation {
  String timestamp;
  String userId;
  String violationType;

  ExamViolation({
    required this.timestamp,
    required this.userId,
    required this.violationType,
  });

  factory ExamViolation.fromJson(Map<String, dynamic> json) {
    return ExamViolation(
      timestamp: json['timestamp'],
      userId: json['user_id'],
      violationType: json['violation_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp,
      'user_id': userId,
      'violation_type': violationType,
    };
  }
}