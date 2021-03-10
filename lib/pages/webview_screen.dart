import 'package:flutter/material.dart';
import 'package:groubuy/widgets/regular_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;
  final String javaScript;
  final bool showChat;

  WebViewScreen(
      {this.title, @required this.url, this.showChat, this.javaScript});

  @override
  _StateWebViewScreen createState() => _StateWebViewScreen();
}

class _StateWebViewScreen extends State<WebViewScreen> {
  WebViewController _controller;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final bool showChat = widget.showChat ?? false;

    return SafeArea(
      child: Scaffold(
        appBar: RegularAppbar(),
        body: _loading
            ? Center(child: CircularProgressIndicator())
            : WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.url,
                onWebViewCreated: (WebViewController controller) async {
                  _controller = controller;
                },
                onPageStarted: (s) {
                  // setState(() {
                  //   _loading = true;
                  // });
                },
                onPageFinished: (s) async {
                  await _controller.evaluateJavascript(widget.javaScript);
                  setState(() {
                    _loading = false;
                  });
                },
              ),
      ),
    );
  }
}
