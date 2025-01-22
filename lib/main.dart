import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:ueh_mobile_app/services/auth_service.dart';
import 'package:ueh_mobile_app/database/local_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");
  await LocalDatabase().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        Provider<AuthService>(
        create: (_) => AuthService(),
    ),
    ],
    child: MaterialApp(
      title: 'UEH demo app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.welcomeHome,
      onGenerateRoute: AppRoutes.generateRoute,
    ),
    );
  }
}


Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedIn = prefs.getBool('isLoggedIn');
  return isLoggedIn ?? false;
}