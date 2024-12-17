import 'package:ueh_mobile_app/utils/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13),
                    child: Center(
                      child: Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            customText(
                                txt: "Welcome",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                )),
                            const SizedBox(
                              height: 8,
                            ),
                            customText(
                                txt:
                                "Please login or sign up to continue using our app.",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            Image.asset("assets/images/img1.png"),
                            const SizedBox(
                              height: 50,
                            ),
                            customText(
                                txt: "Enter via social networks",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                  inkwellButtons(
                                      image: Image.asset("assets/images/img3.png"),
                                      onTap: () {
                                            print("Nút đã được nhấn!");

                                        },
                                  ),
                                const SizedBox(width: 37),
                                inkwellButtons(
                                  image: Image.asset("assets/images/img4.png"),
                                  onTap: () {
                                    print("Nút đã được nhấn!");

                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            customText(
                                txt: "or login with email",
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                )),
                            const SizedBox(
                              height: 50,
                            ),
                            InkWell(
                              child: signUpContainer(st: "Sign Up"),
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/face_login');
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            InkWell(
                              child: RichText(
                                text: richTextSpan(
                                    one: "Don’t have an account ? ", two: "LogIn"),
                              ),
                              onTap: () {
                                Navigator.pushReplacementNamed(context, '/form_login');

                              },
                            ),
                            //Text("data"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            )
          ],
        )

      ),
    );
  }
}
