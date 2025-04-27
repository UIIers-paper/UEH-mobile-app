import 'package:ueh_mobile_app/utils/exports.dart';

class PhoneLoginPage extends StatefulWidget {
  @override
  _PhoneLoginPageState createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {


  void _sendCode() async {
   
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
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _sendCode,
              child: Text("Send Verification Code"),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: "OTP Code"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
            
              },
              child: Text("Verify and Login"),
            ),
          ],
        ),
      ),
    );
  }
}