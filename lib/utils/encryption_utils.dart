import 'package:encrypt/encrypt.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';

class EncryptionUtils {
  static String getKey() {
    return dotenv.env['ENCRYPTION_KEY'] ?? 'default_32_byte_key_placeholder';
  }

  static IV generateIV() {
    final random = Random.secure();
    final ivBytes = Uint8List.fromList(List<int>.generate(16, (_) => random.nextInt(256)));
    return IV(ivBytes);
  }

  static String encryptString(String plainText) {
    final key = Key.fromUtf8(getKey());
    final iv = generateIV();
    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return '${base64UrlEncode(iv.bytes)}:${encrypted.base64}';
  }

  static String decryptString(String encryptedText) {
    final key = Key.fromUtf8(getKey());

    final parts = encryptedText.split(':');
    if (parts.length != 2) throw Exception('Invalid encrypted format');

    final iv = IV.fromBase64(parts[0]);
    final encrypter = Encrypter(AES(key));

    return encrypter.decrypt64(parts[1], iv: iv);
  }
}