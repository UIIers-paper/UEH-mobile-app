import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:ueh_mobile_app/utils/encryption_utils.dart';

class FileService {
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

    final htmlContent = await File(originalFilePath).readAsString();
    final encryptedContent = EncryptionUtils.encryptString(htmlContent);

    final encryptedFile = File(encryptedFilePath);
    await encryptedFile.writeAsString(encryptedContent);

    await File(originalFilePath).delete();
  }

  Future<String?> decryptHtmlFile(String encryptedFileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final encryptedFilePath = '${directory.path}/$encryptedFileName';

    final encryptedFile = File(encryptedFilePath);
    if (!await encryptedFile.exists()) return null;

    final encryptedContent = await encryptedFile.readAsString();
    return EncryptionUtils.decryptString(encryptedContent);
  }
}