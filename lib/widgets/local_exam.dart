import 'package:ueh_mobile_app/utils/exports.dart';


class LocalHtmlViewer extends StatefulWidget {
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
    _loadHtmlFromAssets();
  }

  Future<void> _loadHtmlFromAssets() async {
    try {
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/exam.html';
      final fileData = await DefaultAssetBundle.of(context).loadString('assets/html/exam.html');
      final file = File(filePath);
      await file.writeAsString(fileData);
      setState(() {
        localFilePath = filePath;
      });
    } catch (e) {
      print("Error loading HTML file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: localFilePath.isEmpty
          ? Center(child: CircularProgressIndicator())
          : WebViewWidget(
              controller: controller..loadFile(localFilePath),
            ),
    );
  }
}
