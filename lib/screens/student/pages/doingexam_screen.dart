import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/widgets/bottomAnswer_widget.dart';
import 'package:ueh_mobile_app/widgets/localExam_widget.dart';
import 'package:ueh_mobile_app/services/api_service.dart';
import 'package:ueh_mobile_app/models/exam_model.dart';
class DoingExamScreen extends StatefulWidget {
  final VoidCallback onFinish;
  final String examId;

  DoingExamScreen({required this.onFinish, required this.examId});
  @override
  _DoingExamScreenState createState() => _DoingExamScreenState();
}

class _DoingExamScreenState extends State<DoingExamScreen> with WidgetsBindingObserver {
  final NetworkService networkService = NetworkService();
  final UserService _userLog = UserService();
  List<ExamList>? _examData;
  bool _isLoading = true;
  bool isBottomSheetOpen = false;
  int currentQuestionIndex = 0;
  final List<String> questions = ["Câu hỏi 1", "Câu hỏi 2", "Câu hỏi 3"];
  String selectedAnswer = "";
  bool isSubmitted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    networkService.monitorNetwork().listen((ConnectivityResult result) {
      if (result != ConnectivityResult.none) {
        _lockExam("network");
        // _userLog.recordViolation("network");
      }
    });
  }


  Future<void> _fetchData() async {
    try {
      final apiService = ApiService("${dotenv.env['API_URL']}/exams");
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



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _lockExam("app_paused");
      // _userLog.recordViolation("app_paused");
    }
  }

  void _lockExam(String error) {
    if (isSubmitted) return;
    print("vi phạm");
    _userLog.recordViolation(error);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Bạn đã vi phạm quy chế thi'),
        backgroundColor: Colors.red,
      ),
    );
    // Navigator.pushReplacementNamed(context, '/error');
  }

  void _toggleBottomSheet() {
    setState(() {
      isBottomSheetOpen = !isBottomSheetOpen;
    });

    if (isBottomSheetOpen) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => BottomAnswerWidget(
          numberOfQuestions: 40,
          currentQuestionIndex: currentQuestionIndex,
          selectedAnswer: selectedAnswer,
          onAnswerChanged: (value) {
            setState(() {
              selectedAnswer = value ?? "";
            });
          },
          onClose: () {
            setState(() {
              isBottomSheetOpen = false;
            });
            Navigator.pop(context);
          },
          onFinish: _submitExam,
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  void _submitExam() {
    setState(() {
      isSubmitted = true;
    });
    widget.onFinish();
    // Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (route) => false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đề Thi"),
      ),
      body: Stack(
        children: [
          LocalHtmlViewer(),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _toggleBottomSheet,
              child: Icon(isBottomSheetOpen ? Icons.close : Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}


