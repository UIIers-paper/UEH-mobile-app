import 'package:ueh_mobile_app/models/exam_model.dart';
import 'package:ueh_mobile_app/models/examViolations_model.dart';

List<ExamModel> mockExams = [
  ExamModel(
    id: 1,
    examCode: "CT001",
    displayName: "Kỳ thi Lập trình Web",
    room: "P101",
    examDateTime: DateTime.parse("2025-07-01T08:00:00"),
    date: "01/07/2025",
    examName: "Đề thi Lập trình Web",
    timeLimit: 60,
    startAt: null,
    finishAt: null,
    status: 0,
  ),
  ExamModel(
    id: 2,
    examCode: "CT002",
    displayName: "Kỳ thi Cấu trúc dữ liệu",
    room: "P102",
    examDateTime: DateTime.parse("2025-07-02T09:30:00"),
    date: "02/07/2025",
    examName: "Đề thi Cấu trúc dữ liệu",
    timeLimit: 90,
    startAt: DateTime.parse("2025-07-02T09:35:00"),
    finishAt: null,
    status: 1,
  ),
  ExamModel(
    id: 3,
    examCode: "CT003",
    displayName: "Kỳ thi Mạng máy tính",
    room: "P103",
    examDateTime: DateTime.parse("2025-07-03T13:00:00"),
    date: "03/07/2025",
    examName: "Đề thi Mạng máy tính",
    timeLimit: 75,
    startAt: null,
    finishAt: null,
    status: 0,
  ),
  ExamModel(
    id: 4,
    examCode: "CT004",
    displayName: "Kỳ thi Cơ sở dữ liệu",
    room: "P104",
    examDateTime: DateTime.parse("2025-07-04T10:00:00"),
    date: "04/07/2025",
    examName: "Đề thi Cơ sở dữ liệu",
    timeLimit: 60,
    startAt: DateTime.parse("2025-07-04T10:05:00"),
    finishAt: DateTime.parse("2025-07-04T11:05:00"),
    status: 2,
  ),
];


List<ExamViolation> mockExamViolations = [
  ExamViolation(
    timestamp: "2025-01-22T12:14:07.250245",
    userId: "IYuQjML740clgfbxjcWhuyYo8Y92",
    violationType: "network",
  ),
];