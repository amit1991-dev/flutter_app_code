import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key, required this.text, required this.url})
      : super(key: key);

  final String text;
  final String url;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState(
        url: url, 
        text: text, 
      );
}

class _WebViewScreenState extends State<WebViewScreen> {
  final String url;
  final String text;
  late final WebViewController controller;

  _WebViewScreenState({required this.url, required this.text});

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
