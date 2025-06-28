import 'package:encrypt/encrypt.dart';
import '../configs/aes_config.dart';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:math';

class EncryptionUtils {
  static Key getKey() {
    final keyString = AESConfig.aesKey;
    if (keyString.length != 32) throw Exception('AES_KEY phải dài 32 ký tự');
    return Key.fromUtf8(keyString);
  }

  static IV getIV() {
    final ivString = AESConfig.aesIV;
    if (ivString.length != 16) throw Exception('AES_IV phải dài 16 ký tự');
    return IV.fromUtf8(ivString);
  }

  static IV generateIV() {
    final random = Random.secure();
    final ivBytes = Uint8List.fromList(List<int>.generate(16, (_) => random.nextInt(256)));
    return IV(ivBytes);
  }

  static String encryptString(String plainText) {
    final key = getKey();
    final iv = getIV();
    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return '${base64UrlEncode(iv.bytes)}:${encrypted.base64}';
  }

  static String decryptString(String encryptedText) {
    final key = getKey();
    final iv = getIV();
    final parts = encryptedText.split(':');
    if (parts.length != 2) throw Exception('Invalid encrypted format');
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt64(parts[1], iv: iv);
  }
}