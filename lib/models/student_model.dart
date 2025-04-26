class StudentModel {
  final String studentId;
  final String name;
  final String birthdate;
  final String course;
  final String email;
  final String phone;
  final String major;
  final String address;
  final String classId;
  final String imageUrl;

  StudentModel({
    required this.studentId,
    required this.name,
    required this.birthdate,
    required this.course,
    required this.email,
    required this.phone,
    required this.major,
    required this.address,
    required this.classId,
    required this.imageUrl,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentId: json['studentId'],
      name: json['name'],
      birthdate: json['birthdate'],
      course: json['course'],
      email: json['email'],
      phone: json['phone'],
      major: json['major'],
      address: json['address'],
      classId: json['classId'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'name': name,
      'birthdate': birthdate,
      'course': course,
      'email': email,
      'phone': phone,
      'major': major,
      'address': address,
      'classId': classId,
      'imageUrl': imageUrl,
    };
  }
}