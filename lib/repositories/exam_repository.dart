import 'package:ueh_mobile_app/models/exam_model.dart';
import 'package:ueh_mobile_app/database/local_database.dart';

class ExamRepository {
  final LocalDatabase _dbHelper = LocalDatabase();

  Future<List<ExamModel>> fetchExamsWithFileStatus(List<dynamic> apiData) async {
    final exams = ExamModel.examModelFromJson(apiData);

    for (var exam in exams) {
      final hasFile = await _dbHelper.checkIsSaved(exam.examId);
      exam.isSaved = hasFile;
    }

    return exams;
  }
}