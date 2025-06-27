import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:ueh_mobile_app/services/network_service.dart';
import 'package:ueh_mobile_app/screens/student/pages/doingexam_screen.dart';
import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/providers/network_status_provider.dart';

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final NetworkService networkService = NetworkService();

  void _doExercise(bool isInternetConnected, String examId) async {
    bool isAirplaneModeEnabled = await networkService.isAirplaneModeEnabled();
    if (isInternetConnected || !isAirplaneModeEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Bạn cần tắt Wi-Fi và bật chế độ máy bay để làm bài thi.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DoingExamScreen(
                onFinish: _finishExercise,
                examId: examId,
              ),
        ),
      );
    }
  }

  void _finishExercise() async {
    Navigator.pushNamed(
      context,
      AppRoutes.waitingScreen,
    );
  }




  @override
  Widget build(BuildContext context) {
    final String examId = ModalRoute.of(context)?.settings.arguments as String;
    final isConnected =
        context.watch<NetworkStatusProvider>().isInternetConnected;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bài Thi",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xA0DAE4F5)),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo, 
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()=>_doExercise(
            isConnected,
            examId,
            )
            ,
          child: Text("Làm bài thi"),
        ),
      ),
    );
  }

}







