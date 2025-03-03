class Subject {
  final String subjectId;
  final String name;

  Subject({
    required this.subjectId,
    required this.name,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectId: json['subjectId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subjectId': subjectId,
      'name': name,
    };
  }
}
