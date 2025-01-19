import 'package:ueh_mobile_app/utils/exports.dart';
// import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ueh_mobile_app/services/user_service.dart';
class AuthService {
  final clientId = dotenv.env['MICROSOFT_CLIENT_ID'];
  final tenantId = dotenv.env['MICROSOFT_TENANT_ID'];
  final redirectUri = dotenv.env['MICROSOFT_REDIRECT_URI'];
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final UserService _userService = UserService();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
    dotenv.env['GOOGLE_CLIENT_ID'],
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

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
      print('google ....');
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      print('google ....');
      if (googleAuth.accessToken == null || googleAuth.idToken == null) {
        return null;
      }

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
      final code = Uri.parse(result).queryParameters['code'];
      final response = await _auth.signInWithCustomToken(code!);
      return response.user;
    } catch (e) {
      print('Đăng nhập Microsoft thất bại: $e');
      return null;
    }
  }

  Future<void> signInWithPhone(String phoneNumber, Function(String) onCodeSent) async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification Failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> saveUserAuthentication(User? user, BuildContext context) async{
    final uid = user!.uid;
    await _storage.write(key: 'uid', value: uid);
    final idTokenResult = await user!.getIdTokenResult(true);
    final idToken = idTokenResult.token;
    await _storage.write(key: 'idToken', value: idToken);
    Navigator.pushReplacementNamed(context, '/dashboard');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đăng nhập thành công!")),
    );

  }

  Future<void> verifyPhoneCode({required String verificationId, required String smsCode, required BuildContext context}) async {
    try {
      final credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } catch(e){
      print("Verification failed: $e");
    }
  }


  Future<void> linkAccountWithCredential(AuthCredential credential, BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.linkWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Liên kết phương thức đăng nhập thành công!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Người dùng chưa đăng nhập!")),
        );
      }
    } catch (e) {
      print("Lỗi khi liên kết tài khoản: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Liên kết tài khoản thất bại: ${e.toString()}")),
      );
    }
  }

  Future<void> linkGoogleAccount(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Không thể lấy thông tin từ Google")),
        );
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await linkAccountWithCredential(credential, context);
    } catch (e) {
      print("Lỗi khi liên kết Google: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Liên kết Google thất bại: ${e.toString()}")),
      );
    }
  }

  Future<void> linkPhoneAccount({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required BuildContext context,
  }) async {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await linkAccountWithCredential(credential, context);
      },
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Xác minh số điện thoại thất bại: ${e.message}")),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> linkMicrosoftAccount(BuildContext context) async {
    try {
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
      final code = Uri.parse(result).queryParameters['code'];

      if (code == null) {
        throw Exception("Không lấy được mã xác thực Microsoft.");
      }
      final AuthCredential credential = OAuthProvider("microsoft.com").credential(
        idToken: code,
      );
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        throw Exception("Không tìm thấy người dùng hiện tại.");
      }
      await currentUser.linkWithCredential(credential);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Liên kết tài khoản Microsoft thành công!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Liên kết tài khoản Microsoft thất bại: $e")),
      );
    }
  }

  Future<void> logout(BuildContext context) async {
    try {
      await _userService.updateLogoutTime();
      await _storage.deleteAll();
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/auth_home');
    } catch (e) {
      print("Logout failed: $e");
    }
  }


}
