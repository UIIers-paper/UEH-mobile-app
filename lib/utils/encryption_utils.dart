import 'package:encrypt/encrypt.dart';

class EncryptionUtils {
  static String encryptString(String plainText) {
    final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.encrypt(plainText, iv: iv).base64;
  }

  static String decryptString(String encryptedText) {
    final key = Key.fromUtf8('my32lengthsupersecretnooneknows1');
    final iv = IV.fromLength(16);
    final encrypter = Encrypter(AES(key));
    return encrypter.decrypt64(encryptedText, iv: iv);
  }
}