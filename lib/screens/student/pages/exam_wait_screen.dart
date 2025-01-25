import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/providers/network_status_provider.dart';

class ExamWaitScreen extends StatefulWidget {
  @override
  _ExamWaitScreenState createState() => _ExamWaitScreenState();
}

class _ExamWaitScreenState extends State<ExamWaitScreen> {
  final NetworkService networkService = NetworkService();
  final UserService _userService = UserService();
  bool isInternetConnected = true;
  int countdown = 5;
  bool isLoading = true;
  late Timer _networkCheckTimer;

  @override
  void initState() {
    super.initState();
    _startNetworkCheck(); 
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final isConnected = Provider.of<NetworkStatusProvider>(context, listen: true).isInternetConnected;
    if (isInternetConnected != isConnected) {
      isInternetConnected = isConnected;
      _monitorNetworkAndSyncLogs(isInternetConnected);
    }
  }

  void _startNetworkCheck() {
    _networkCheckTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      final isConnected =
          Provider.of<NetworkStatusProvider>(context, listen: false)
              .isInternetConnected;

      _handleNetworkChange(isConnected);
    });
  }

  void _handleNetworkChange(bool isConnected) async {
    if (isConnected) {
      print("WiFi is enabled");
      await _syncLogsToFirebase();
    } else {
      print("WiFi is disabled");
       SchedulerBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bạn cần bật wifi để hoàn tất nộp bài thi.',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.yellow,
        ),
      );
    });
    }
  }

  void _monitorNetworkAndSyncLogs(bool isConnected) async {
      if (isConnected) {
        print("Wifi is enabled");
        print(isConnected);
        await _syncLogsToFirebase();
      } else {
          print("Wifi is disabled");
              SchedulerBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Bạn cần bật wifi để hoàn tất nộp bài thi.',
                      style: TextStyle(color: Colors.black),
                    ),
                    backgroundColor: Colors.yellow,
                  ),
                );
              });
          final isConnected = Provider.of<NetworkStatusProvider>(context, listen: true).isInternetConnected;
          if (isInternetConnected != isConnected) {
            isInternetConnected = isConnected;
            await _syncLogsToFirebase();
          }
      }
    
    
  }

  void _startCountdown() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown == 0) {
        timer.cancel();
        Navigator.pushNamed(context, AppRoutes.dashboardScreen);
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  Future<void> _syncLogsToFirebase() async {
    if (isLoading) {
      print("Syncing logs to Firebase...");
      await _userService.syncLogsToFirebase();
      print("Logs synchronized!");

      setState(() {
        isLoading = false;
      });

      _startCountdown();
    }
  }

  @override
  void dispose() {
    _networkCheckTimer.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exam Alert")),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Redirecting to dashboard in $countdown seconds...",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
