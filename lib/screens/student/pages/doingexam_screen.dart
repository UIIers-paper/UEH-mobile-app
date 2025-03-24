import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:ueh_mobile_app/widgets/bottomAnswer_widget.dart';
import 'package:ueh_mobile_app/widgets/localExam_widget.dart';
import 'package:ueh_mobile_app/database/local_database.dart';

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
  Uint8List? _htmlContent;
  Map<int, String> savedAnswers = {};
  bool _isLoading = true;
  bool isBottomSheetOpen = false;
  int currentQuestionIndex = 0;
  final List<String> questions = ["Câu hỏi 1", "Câu hỏi 2", "Câu hỏi 3"];
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
    _loadSavedAnswers();
    _loadHtmlContent();
  }

  Future<void> _loadSavedAnswers() async {
    Map<int, String> answers = await LocalDatabase().loadAnswers(widget.examId);
    setState(() {
      savedAnswers = answers;
    });
  }


  Future<void> _loadHtmlContent() async {
    try {
      Uint8List? htmlContent = await LocalDatabase().getEncryptedFile(widget.examId);
      if (htmlContent != null) {
        setState(() {
          _htmlContent = htmlContent; 
          _isLoading = false; 
        });
      } else {
        throw Exception("Không tìm thấy file HTML trong cơ sở dữ liệu");
      }
    } catch (e) {
      setState(() {
        _isLoading = false; 
      });
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
          savedAnswers: savedAnswers,
          onAnswerChanged: (questionIndex, answer) async {
            setState(() {
              savedAnswers[questionIndex] = answer;
            });
            await LocalDatabase().saveAnswer(widget.examId, questionIndex, answer);
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
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Đề Thi"),
      ),
      body: Stack(
        children: [
          LocalHtmlViewer(htmlContent: _htmlContent!),
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


