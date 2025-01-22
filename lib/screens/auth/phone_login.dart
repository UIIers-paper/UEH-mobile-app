import 'package:ueh_mobile_app/utils/exports.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  final AuthService _authService = AuthService();
  String _verificationId = '';
  String _smsCode = '';
  String _phoneNumber = '';

  void _sendCode() async {
    await _authService.signInWithPhone(_phoneNumber, (verificationId) {
      setState(() {
        _verificationId = verificationId;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Phone Authentication')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Phone Number"),
              onChanged: (value) => _phoneNumber = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendCode,
              child: Text("Send Verification Code"),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: "OTP Code"),
              onChanged: (value) => _smsCode = value,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
              _authService.verifyPhoneCode(
                  verificationId: _verificationId,
                  smsCode: _smsCode,
                  context: context);
              },
              child: Text("Verify and Login"),
            ),
          ],
        ),
      ),
    );
  }
}
