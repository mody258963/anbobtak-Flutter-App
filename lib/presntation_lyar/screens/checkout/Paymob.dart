import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebView extends StatefulWidget {
  final String? iframeUrl;

  const PaymobWebView({super.key, required this.iframeUrl});
  @override
  _PaymobWebViewState createState() => _PaymobWebViewState();
}

class _PaymobWebViewState extends State<PaymobWebView> {
 final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    super.initState();
    _controller.loadRequest(Uri.parse(widget.iframeUrl!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paymob Payment'),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
