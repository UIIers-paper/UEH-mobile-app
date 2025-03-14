import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ueh_mobile_app/utils/encryption_utils.dart';
import 'package:ueh_mobile_app/database/local_database.dart';
class FileService {
  final LocalDatabase _db = LocalDatabase();

  Future<String> saveHtmlToFile(String htmlContent, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsString(htmlContent);
    return filePath;
  }

  Future<void> encryptHtmlFile(String originalFilePath, String encryptedFileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final encryptedFilePath = '${directory.path}/$encryptedFileName';
    try {
      final htmlContent = await File(originalFilePath).readAsString();
      
      final encryptionKey = EncryptionUtils.generateKey();
      await _db.saveEncryptionKey(encryptedFileName, encryptionKey);
  
      final encryptedContent = EncryptionUtils.encryptString(htmlContent, encryptionKey);
      await File(encryptedFilePath).writeAsString(encryptedContent);

      await File(originalFilePath).delete();
    } catch (e) {
      print('Error encrypting file: $e');
    }
  }

  Future<String?> decryptHtmlFile(String encryptedFileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final encryptedFilePath = '${directory.path}/$encryptedFileName';

      final encryptedFile = File(encryptedFilePath);
      if (!await encryptedFile.exists()) {
        print('Không tìm thấy file mã hóa: $encryptedFilePath');
        return null;
      }
      final encryptionKey = await _db.getEncryptionKey(encryptedFileName);
      if (encryptionKey == null) {
        print('Không tìm thấy khóa giải mã cho file: $encryptedFileName');
        return null;
      }

      final encryptedContent = await encryptedFile.readAsString();
      return EncryptionUtils.decryptString(encryptedContent, encryptionKey);
    } catch (e) {
      print('Lỗi khi giải mã file: $e');
      return null;
    }
  }
}