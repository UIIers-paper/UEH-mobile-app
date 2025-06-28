import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:http/io_client.dart';


class ApiConstants {
  static String get baseUrl => dotenv.env['SERVER_URL'] ?? '';
  static String get registerEndpoint => '$baseUrl/api/Auth/register';
  static String get loginEndpoint => '$baseUrl/api/Auth/login';
  // Lên production thì ko được xài nữa, chỉ xài cho môi trường dev
  static final client = IOClient(HttpClient()
    ..badCertificateCallback = (cert, host, port) => true);
}