import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:provider/provider.dart';
import 'package:ueh_mobile_app/database/local_database.dart';
import 'package:ueh_mobile_app/providers/network_status_provider.dart';
import 'package:ueh_mobile_app/providers/airplane_status_provider.dart';
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
          ChangeNotifierProvider<NetworkStatusProvider>(
            create: (_) => NetworkStatusProvider(),
          ),
          ChangeNotifierProvider<AirplaneModeProvider>(
              create: (_) => AirplaneModeProvider()
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