import 'package:flutter_dotenv/flutter_dotenv.dart';

class AESConfig {
  static String get aesKey => dotenv.env['AES_KEY'] ?? '';
  static String get aesIV  => dotenv.env['AES_IV'] ?? '';
}
