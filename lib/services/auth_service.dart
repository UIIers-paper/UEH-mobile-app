import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/models/auth_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
class AuthService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  // Lên production thì ko được xài nữa, chỉ xài cho môi trường dev
  final client = IOClient(HttpClient()
    ..badCertificateCallback = (cert, host, port) => true);
  

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    try {
      print(jsonEncode({
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword

      }));
      print(ApiConstants.registerEndpoint);
      print('${ApiConstants.baseUrl}/api/Auth/register');

      final response = await client.post(
        Uri.parse(ApiConstants.registerEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword

        }),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
        await _storage.write(key: 'token', value: authResponse.token);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đăng ký thành công!")),
        );
      } else {
        throw Exception('Đăng ký thất bại: ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng ký thất bại: ${e.toString()}")),
      );
    }
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await client.post(
        Uri.parse(ApiConstants.loginEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        print("Login response: ${response.body}");
        final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
        await _storage.write(key: 'token', value: authResponse.token);
        Navigator.pushReplacementNamed(context, AppRoutes.dashboardScreen);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đăng nhập thành công!")),
        );
      } else {
        throw Exception('Đăng nhập thất bại: ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng nhập thất bại: ${e.toString()}")),
      );
    }
  }

  Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/auth/reset-password'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email đặt lại mật khẩu đã được gửi.")),
        );
      } else {
        throw Exception('Có lỗi xảy ra: ${jsonDecode(response.body)['message']}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Có lỗi xảy ra: ${e.toString()}")),
      );
    }
  }

  

  Future<void> logout(BuildContext context) async {
    try {
      await _storage.deleteAll();
      Navigator.pushReplacementNamed(context, AppRoutes.authHome);
    } catch (e) {
      print("Logout failed: $e");
    }
  }


}