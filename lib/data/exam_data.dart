import 'package:ueh_mobile_app/models/exam_model.dart';
import 'package:ueh_mobile_app/models/examViolations_model.dart';

List<ExamModel> mockExams = [
  ExamModel(
    examId: "E001",
    teacherName: "Mr. John Doe",
    courseName: "Mathematics 101",
    subject: "Algebra",
    dateTime: DateTime.now(),
    startTime: "08:00 AM",
    endTime: "10:00 AM",
    questionNumbers: 50,
    limitTime: 120,
    date: "2025-03-05",
    duration: 120,
  ),
  ExamModel(
    examId: "E002",
    teacherName: "Ms. Jane Smith",
    courseName: "Physics 102",
    subject: "Mechanics",
    dateTime: DateTime.now(),
    startTime: "09:30 AM",
    endTime: "11:00 AM",
    questionNumbers: 40,
    limitTime: 90,
    date: "2025-03-04",
    duration: 90,
  ),
];


List<ExamViolation> mockExamViolations = [
  ExamViolation(
    timestamp: "2025-01-22T12:14:07.250245",
    userId: "IYuQjML740clgfbxjcWhuyYo8Y92",
    violationType: "network",
  ),
];