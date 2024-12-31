import 'package:flutter/material.dart';
import 'package:ueh_mobile_app/configs/routes.dart';

import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/widgets/social_button.dart';
import 'package:ueh_mobile_app/services/auth_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class FormLogin extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<FormLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  // bool _rememberMe = false;

  void _signInWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      print("Verification failed: $e");
    }
  }

  void _signInWithMicrosoft() async {
    try {
      await _authService.signInWithMicrosoft();
    } catch (e) {
      print("Verification failed: $e");
    }
  }

  void _signInWithPhone() async{
    try{

    }catch (e){
      print("Verification failed: $e");
    }
  }

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
                  // Navigator.pushNamed(context, App);
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
                  SocialLoginButton(icon: FontAwesomeIcons.google, color: Colors.blueAccent, onLogin: _signInWithGoogle),
                  SocialLoginButton(icon: FontAwesomeIcons.microsoft, color:  Colors.blueAccent, onLogin: _signInWithMicrosoft),
                  SocialLoginButton(icon: FontAwesomeIcons.phone, color: Colors.black, onLogin: _signInWithPhone),

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
}



