import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ueh_mobile_app/services/network_service.dart';

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> with WidgetsBindingObserver {
  final NetworkService networkService = NetworkService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    networkService.monitorNetwork().listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        _lockExam();
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lockExam(); // Chuyển sang nền => khóa bài thi
    }
  }

  void _lockExam() {
    // Xử lý logic khóa bài thi
    print("Bài thi đã bị khóa!");
    Navigator.pushReplacementNamed(context, '/error');
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bài thi")),
      body: Center(
        child: Text("Đây là màn hình thi"),
      ),
    );
  }
}
