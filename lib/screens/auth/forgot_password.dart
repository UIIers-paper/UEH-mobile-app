import 'package:ueh_mobile_app/utils/exports.dart';

class ForgotPassword extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img1.png',
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              "Forgot\nPassword?",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Color(0xFF092553),
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Don't worry! It happens. Please enter the email or mobile number associated with your account.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email, color: Colors.grey),
                labelText: 'Email ID / Mobile number',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),

            // Căn phải cho nút Submit
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  String emailOrPhone = emailController.text;
                  print("Submitted: $emailOrPhone");
                  String email = emailController.text.trim();
                  _authService.sendPasswordResetEmail(email, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A65F9),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 150),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// class ForgotPassword extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();
//   final AuthService _authService = AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Quên mật khẩu"),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: "Email"),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 String email = emailController.text.trim();
//                 _authService.sendPasswordResetEmail(email, context);
//               },
//               child: Text("Gửi email đặt lại mật khẩu"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





