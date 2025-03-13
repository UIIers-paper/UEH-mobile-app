import 'package:ueh_mobile_app/configs/routes.dart';
import 'package:ueh_mobile_app/data/exam_data.dart';
import 'package:ueh_mobile_app/services/api_service.dart';
import 'package:ueh_mobile_app/screens/student/pages/doingexam_screen.dart';
import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/models/exam_model.dart';
import 'package:ueh_mobile_app/widgets/examCard_widget.dart';

class ExamListScreen extends StatefulWidget {
  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamListScreen> {
  final NetworkService networkService = NetworkService();
  List<ExamList>? _examData;
  bool _isLoading = true;
  // late StudentModel student;


  @override
  void initState() {
    super.initState();
    _fetchData();
  }


  Future<void> _fetchData() async {
    try {
      final apiService = ApiService("$dotenv.env['API_URL']/exams");
      final List<ExamList> examData = await apiService.fetchDataList<List<ExamList>>((json) => ExamList.examListFromJson(json));

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
    final List<ExamList> examList = _examData ?? mockExams;
    Map<String, List<ExamList>> classesByDay = {};
    examList.sort((a, b) => a.date.compareTo(b.date));
    for (var examItem in examList) {
      final day = _getDayOfWeek(examItem.date);
      if (classesByDay[day] == null) {
        classesByDay[day] = [];
      }
      classesByDay[day]!.add(examItem);
    }

    return ListView(
      children: [
        for (var day in classesByDay.keys)
          _buildDaySection(day, classesByDay[day]!),
      ],
    );
  }
}

String _getDayOfWeek(String dayTime) {
  final days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];
  try {
    DateTime date = DateTime.parse(dayTime);
    int weekdayIndex = date.weekday;
    return days[weekdayIndex - 1];
  } catch (e) {
    return 'Unknown';
  }
}



Widget _buildDaySection(String day, List<ExamList> exams) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(width: 10,),
            Text(
              day,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Expanded(child: Divider(
              color: Colors.grey,
              thickness: 1,
            )),
          ],
        ),
      ),
      for (var examItem in exams)
        ExamCard(
          classId: examItem.examId,
          classCodeName: examItem.teacherName,
          className: examItem.courseName,
          dayTime: examItem.date,
        ),
    ],
  );
}


