import 'package:ueh_mobile_app/utils/exports.dart';
// import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = FlutterSecureStorage();

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


  Future<void> logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/auth_home');
    } catch (e) {
      print("Logout failed: $e");
    }
  }



}
