import 'package:ueh_mobile_app/utils/exports.dart';
// import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> registerWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = userCredential.user!.uid;
      await _storage.write(key: 'uid', value: uid);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng ký thành công!")),
      );
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
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final uid = userCredential.user!.uid;
      await _storage.write(key: 'uid', value: uid);

      final idTokenResult = await userCredential.user!.getIdTokenResult(true);
      final idToken = idTokenResult.token;
      if (idToken == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: Token không hợp lệ")),
        );
        return;
      }
      await _storage.write(key: 'idToken', value: idToken);
      Navigator.pushReplacementNamed(context, '/dashboard');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng nhập thành công!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Đăng nhập thất bại: ${e.toString()}")),
      );
    }
  }

  Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email đặt lại mật khẩu đã được gửi.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Có lỗi xảy ra: ${e.toString()}")),
      );
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null; 
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } catch (e) {
      print('Đăng nhập Google thất bại: $e');
      return null;
    }
  }

  Future<User?> signInWithMicrosoft() async {
    try {
      // Thay YOUR_CLIENT_ID và YOUR_TENANT_ID bằng giá trị thực tế từ Microsoft Azure
      const clientId = "YOUR_CLIENT_ID";
      const tenantId = "YOUR_TENANT_ID";
      const redirectUri = "https://<app-id>.firebaseapp.com/__/auth/handler";

      // Bắt đầu quy trình xác thực
      final authUrl =
          "https://login.microsoftonline.com/$tenantId/oauth2/v2.0/authorize"
          "?client_id=$clientId"
          "&response_type=code"
          "&redirect_uri=$redirectUri"
          "&response_mode=query"
          "&scope=openid profile email";

      final result = await FlutterWebAuth2.authenticate(
        url: authUrl,
        callbackUrlScheme: "https",
      );

      // Lấy mã xác thực từ URL callback
      final code = Uri.parse(result).queryParameters['code'];

      // Gửi mã xác thực tới Firebase để tạo Custom Token
      final response = await _auth.signInWithCustomToken(code!);
      return response.user;
    } catch (e) {
      print('Đăng nhập Microsoft thất bại: $e');
      return null;
    }
  }


  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/auth_home');
    } catch (e) {
      print("Logout failed: $e");
    }
  }



}
