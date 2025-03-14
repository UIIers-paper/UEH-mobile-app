import 'package:encrypt/encrypt.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';

class EncryptionUtils {
  static String generateKey() {
    final random = Random.secure();
    final keyBytes = List<int>.generate(32, (_) => random.nextInt(256));
    return base64UrlEncode(keyBytes);
  }

  // Tạo IV ngẫu nhiên 16 bytes
  static IV generateIV() {
    final random = Random.secure();
    final ivBytes = Uint8List.fromList(List<int>.generate(16, (_) => random.nextInt(256)));
    return IV(ivBytes);
  }

  static String encryptString(String plainText, String base64Key) {
    final key = Key.fromBase64(base64Key);
    final iv = generateIV();
    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    
    // Trả về IV + nội dung đã mã hóa (gộp lại để giải mã sau)
    return '${base64UrlEncode(iv.bytes)}:${encrypted.base64}';
  }

  static String decryptString(String encryptedText, String base64Key) {
    final key = Key.fromBase64(base64Key);

    // Tách IV và nội dung mã hóa từ chuỗi
    final parts = encryptedText.split(':');
    if (parts.length != 2) throw Exception('Invalid encrypted format');

    final iv = IV.fromBase64(parts[0]);
    final encrypter = Encrypter(AES(key));

    return encrypter.decrypt64(parts[1], iv: iv);
  }
}