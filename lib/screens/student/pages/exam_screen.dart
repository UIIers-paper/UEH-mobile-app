import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:ueh_mobile_app/data/exam_data.dart';
import 'package:ueh_mobile_app/services/network_service.dart';
import 'package:ueh_mobile_app/services/api_service.dart';
import 'package:ueh_mobile_app/screens/student/pages/doingexam_screen.dart';
import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/providers/network_status_provider.dart';
import 'package:ueh_mobile_app/models/exam_model.dart';
import 'package:ueh_mobile_app/widgets/examCard_widget.dart';

class ExamScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final NetworkService networkService = NetworkService();
  final List<ExamModel> examList = mockExams;
  bool _isLoading = true;
  // late StudentModel student;
  Map<String, dynamic>? _examData;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final apiService = ApiService("$dotenv.env['API_URL']/student");
      final examData = await apiService.fetchExamData();

      setState(() {
        _examData = examData;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print('Error: $e');
    }
  }

  


  void _doExercise(bool isInternetConnected) async {
    print("Doing exercise...");
    bool isAirplaneModeEnabled = await networkService.isAirplaneModeEnabled();
    print("Connection: ${await networkService.checkNetworkStatus()}");


    print(isInternetConnected);
    if (isInternetConnected || !isAirplaneModeEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Bạn cần tắt Wi-Fi và bật chế độ máy bay để làm bài thi.'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      print('thi');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DoingExamScreen(
                onFinish: _finishExercise,
              ),
        ),
      );
    }
  }

  void _finishExercise() async {
    print("Finish exercise...");
    Navigator.pushNamed(
      context,
      AppRoutes.waitingScreen,
    );
  }




  @override
  Widget build(BuildContext context) {
    final isConnected =
        context.watch<NetworkStatusProvider>().isInternetConnected;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Bài Thi",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xA0DAE4F5)),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo, // Màu nền của AppBar
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()=>_doExercise(isConnected),
          child: Text("Làm bài thi"),
        ),
      ),
    );
  }

}







