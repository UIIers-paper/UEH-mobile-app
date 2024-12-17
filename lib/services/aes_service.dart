import 'package:encrypt/encrypt.dart' as encrypt;
import '../configs/aes_config.dart';

class AESService {
  final key = encrypt.Key.fromUtf8(AESConfig.aesKey);
  final iv = encrypt.IV.fromUtf8(AESConfig.aesIV);
  final encrypter = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromUtf8(AESConfig.aesKey)));

  String encryptText(String text) {
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  String decryptText(String encryptedText) {
    final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
    return decrypted;
  }
}
