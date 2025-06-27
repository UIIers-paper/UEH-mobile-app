// import 'dart:io';
import 'dart:convert';
// import 'package:path_provider/path_provider.dart';
import 'dart:typed_data';
import 'package:ueh_mobile_app/utils/encryption_utils.dart';
class ExamStorage  {
  final String folderName = "assets/html";

  // Future<String> _getStoragePath() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final path = Directory("${directory.path}/$folderName");
  //   if (!await path.exists()) {
  //     await path.create(recursive: true);
  //   }
  //   return path.path;
  // }

  // Future<String> saveHtmlToFile(String base64Content, String fileName) async {
  //   // final storagePath = await _getStoragePath();
  //   // final filePath = '$storagePath/$fileName.html';
  //   final decodedBytes = base64Decode(base64Content);
  //   await File(filePath).writeAsString(utf8.decode(decodedBytes));
  //   return filePath;
  // }

  Future<Uint8List> saveEncryptedExam(String examId, String base64Content) async {
    try {
      final encryptedContent = EncryptionUtils.encryptString(base64Content);
      final encryptedBytes = utf8.encode(encryptedContent);
      final file = Uint8List.fromList(encryptedBytes);
      return file;
    } catch (e) {
      print('Lỗi khi lưu đề thi đã mã hóa: $e');
      throw Exception('Không thể lưu đề thi');
    }
  }


  Future<String?> loadDecryptedExam(Uint8List encryptedData) async {
    try {
      final encryptedString = utf8.decode(encryptedData);
      final decryptedContent = EncryptionUtils.decryptString(encryptedString);
      // final base64Content = base64Encode(utf8.encode(decryptedContent));
      print("Nội dung đã giải mã và chuyển đổi thành Base64: $decryptedContent");
      return decryptedContent; 
    } catch (e) {
      print('Lỗi khi giải mã và chuyển đổi dữ liệu: $e');
      return null;
    }
  }
}