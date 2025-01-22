import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:ueh_mobile_app/utils/exports.dart';

class ExamWaitScreen extends StatefulWidget {
  @override
  _ExamWaitScreenState createState() => _ExamWaitScreenState();
}

class _ExamWaitScreenState extends State<ExamWaitScreen> {
  final NetworkService networkService = NetworkService();
  final UserService _userService = UserService();
  @override
  void initState() {
    super.initState();
    _monitorNetworkAndSyncLogs();
  }

  void _monitorNetworkAndSyncLogs() async {
    bool isWifiEnabled = await networkService.checkNetworkStatus();
    if (isWifiEnabled) {
      print("Wifi is enabled");
      print(isWifiEnabled);
      await _syncLogsToFirebase();
    } else {
      networkService.monitorNetwork().listen((ConnectivityResult result) async {
        if (result != ConnectivityResult.none) {
          await _syncLogsToFirebase();
        }
      });
    }
  }

  Future<void> _syncLogsToFirebase() async {
    await _userService.syncLogsToFirebase();
    print("Logs synchronized to Firebase");

    Navigator.pushNamed(context, AppRoutes.dashboardScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exam Alert")),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
