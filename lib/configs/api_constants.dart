import 'package:ueh_mobile_app/utils/exports.dart';


class ApiConstants {
  static String get baseUrl => dotenv.env['SERVER_URL'] ?? '';
  static String get registerEndpoint => '$baseUrl/auth/register';
  static String get loginEndpoint => '$baseUrl/auth/login';
}