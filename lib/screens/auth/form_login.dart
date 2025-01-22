import 'package:ueh_mobile_app/configs/routes.dart';

import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/widgets/social_button.dart';

class FormLogin extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<FormLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final UserService _userLog = UserService();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldMessengerKey,
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/img1.png"),
              SizedBox(height: 20),
              Text(
                'Login',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email ID',
                  prefixIcon: Icon(Icons.mail, color: Colors.blue),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Stack(
                children: [
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.forgotPassword);
                      },
                      child: Text(
                        'Forgot?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await _authService.loginWithEmailAndPassword(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                    context: context,
                  );
                  await _userLog.logUserInfo();
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A65F9),
                  minimumSize: Size(320, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text('Or, login with...', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialLoginButton(icon: FontAwesomeIcons.google, color: Colors.blueAccent, onLogin: () => _signInWithGoogle(context)),
                  SocialLoginButton(icon: FontAwesomeIcons.microsoft, color:  Colors.blueAccent, onLogin: () => _signInWithMicrosoft(context)),
                  SocialLoginButton(icon: FontAwesomeIcons.phone, color: Colors.black, onLogin: () => _signInWithPhone(context)),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  void _signInWithGoogle(BuildContext context) async {
    try {
      print("login with google");
      User? user = await _authService.signInWithGoogle();
      await _authService.saveUserAuthentication(user, context);
      await _userLog.logUserInfo();
    } catch (e) {
      print("Verification failed: $e");
    }
  }

  void _signInWithMicrosoft(BuildContext context) async {
    try {
      User? user = await _authService.signInWithMicrosoft();
      await _authService.saveUserAuthentication(user, context);
      await _userLog.logUserInfo();
    } catch (e) {
      print("Verification failed: $e");
    }
  }

  void _signInWithPhone(BuildContext context) async{
    try{
      await _userLog.logUserInfo();

    }catch (e){
      print("Verification failed: $e");
    }
  }
}



