import 'package:ueh_mobile_app/utils/exports.dart';


class LocalHtmlViewer extends StatefulWidget {
  final Uint8List htmlContent;
  const LocalHtmlViewer({Key? key, required this.htmlContent}) : super(key: key);
  @override
  _LocalHtmlViewerState createState() => _LocalHtmlViewerState();
}

class _LocalHtmlViewerState extends State<LocalHtmlViewer> {
  late String localFilePath='';
  late WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (url)  {
            setState(() {
              isLoading = false;
            });
          },
        ),
      );
    _loadHtmlFromDatabase();
  }

  // Future<void> _loadHtmlFromAssets() async {
  //   try {
  //     final directory = await getTemporaryDirectory();
  //     final filePath = '${directory.path}/exam_img_binary.html';
  //     final fileData = await DefaultAssetBundle.of(context).loadString('assets/html/exam_img_binary.html');
  //     final file = File(filePath);
  //     await file.writeAsString(fileData);
  //     setState(() {
  //       localFilePath = filePath;
  //     });
  //   } catch (e) {
  //     print("Error loading HTML file: $e");
  //   }
  // }

  Future<void> _loadHtmlFromDatabase() async {
    try {
      final String htmlString = String.fromCharCodes(widget.htmlContent);
      await controller.loadHtmlString(htmlString);
    } catch (e) {
      print("Error loading HTML content from database: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: localFilePath.isEmpty
          ? Center(child: CircularProgressIndicator())
          : WebViewWidget(
              controller: controller,
            ),
    );
  }
}
