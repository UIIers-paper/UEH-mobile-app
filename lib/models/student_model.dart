class StudentModel {
  final String studentId;
  final String name;
  final String email;
  final String phone;
  final String majorId;
  final String address;
  final String classId;

  StudentModel({
    required this.studentId,
    required this.name,
    required this.email,
    required this.phone,
    required this.majorId,
    required this.address,
    required this.classId,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      studentId: json['studentId'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      majorId: json['majorId'],
      address: json['address'],
      classId: json['classId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'studentId': studentId,
      'name': name,
      'email': email,
      'phone': phone,
      'majorId': majorId,
      'address': address,
      'classId': classId,
    };
  }
}
