import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ueh_mobile_app/services/file_service.dart';

class NotificationService {
  final FileService _fileService = FileService();

  Future<void> setupNotifications() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("Handling foreground message...");
      await _handleNotification(message);
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("Handling message when app is opened from notification...");
      await _handleNotification(message);
    });
  }

  Future<void> _handleNotification(RemoteMessage message) async {
    final content = message.data['content'];
    if (content != null) {
      final fileName = 'exam.html';
      final originalFilePath = await _fileService.saveHtmlToFile(content, fileName);
      await _fileService.encryptHtmlFile(originalFilePath, '$fileName.enc');
      print('Exam data saved and encrypted successfully.');
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    print("Handling background message...");
    final content = message.data['content'];
    if (content != null) {
      final fileService = FileService();
      final fileName = 'exam.html';
      final originalFilePath = await fileService.saveHtmlToFile(content, fileName);
      await fileService.encryptHtmlFile(originalFilePath, '$fileName.enc');
      print('Exam data saved and encrypted in background.');
    }
  }
}