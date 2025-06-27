import 'package:ueh_mobile_app/utils/exports.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';

class LocalHtmlViewer extends StatefulWidget {
  final String htmlContent;
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
      )..loadHtmlString(widget.htmlContent);
    // _loadHtmlContent();
    // _loadHtmlFromAssets();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : WebViewWidget(
              controller: controller,
            ),
    //         : WebViewWidget(
    //     controller: controller..loadFile(localFilePath),
    // ),
    );
  }
}
