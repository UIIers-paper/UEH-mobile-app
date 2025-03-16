import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:ueh_mobile_app/utils/encryption_utils.dart';
class ExamStorage  {
  final String folderName = "assets/html";

  Future<String> _getStoragePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = Directory("${directory.path}/$folderName");
    if (!await path.exists()) {
      await path.create(recursive: true);
    }
    return path.path;
  }

  Future<String> saveHtmlToFile(String base64Content, String fileName) async {
    final storagePath = await _getStoragePath();
    final filePath = '$storagePath/$fileName.html';
    final decodedBytes = base64Decode(base64Content);
    await File(filePath).writeAsString(utf8.decode(decodedBytes));
    return filePath;
  }

  Future<File> saveEncryptedExam(String examId, String plainContent) async {
    try {
      final storagePath = await _getStoragePath();
      final encryptedFilePath = '$storagePath/$examId.enc';
      final encryptedContent = EncryptionUtils.encryptString(plainContent);
      final file = File(encryptedFilePath);
      await file.writeAsString(encryptedContent);
      return file;
    } catch (e) {
      print('Lỗi khi lưu đề thi đã mã hóa: $e');
      throw Exception('Không thể lưu đề thi');
    }
  }


  Future<String?> loadDecryptedExam(String examId) async {
    try {
      final storagePath = await _getStoragePath();
      final encryptedFilePath = '$storagePath/$examId.enc';
      final encryptedFile = File(encryptedFilePath);
      if (!await encryptedFile.exists()) {
        print('Không tìm thấy file mã hóa: $encryptedFilePath');
        return null;
      }
      final encryptedContent = await encryptedFile.readAsString();
      return EncryptionUtils.decryptString(encryptedContent);
    } catch (e) {
      print('Lỗi khi giải mã đề thi: $e');
      return null;
    }
  }
}