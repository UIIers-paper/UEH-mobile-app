import 'package:ueh_mobile_app/utils/exports.dart';


class ApiConstants {
  static String get baseUrl => dotenv.env['SERVER_URL'] ?? '';
  static String get registerEndpoint => '$baseUrl/api/Auth/register';
  static String get loginEndpoint => '$baseUrl/api/Auth/login';
}