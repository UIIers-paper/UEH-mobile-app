class ClassModel {
  final String classId;
  final List<String> studentIds;
  final String teacherId;

  ClassModel({
    required this.classId,
    required this.studentIds,
    required this.teacherId,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      classId: json['classId'],
      studentIds: List<String>.from(json['studentIds']),
      teacherId: json['teacherId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'classId': classId,
      'studentIds': studentIds,
      'teacherId': teacherId,
    };
  }
}
