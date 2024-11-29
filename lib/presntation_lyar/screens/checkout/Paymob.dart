import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymobWebView extends StatefulWidget {
  final String iframeUrl;

  const PaymobWebView({Key? key, required this.iframeUrl}) : super(key: key);

  @override
  State<PaymobWebView> createState() => _PaymobWebViewState();
}

class _PaymobWebViewState extends State<PaymobWebView> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
            print("Page started loading: $url"); // Debug URL
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
            print("Page finished loading: $url"); // Debug URL
            _handleUrl(url);
          },
          onNavigationRequest: (NavigationRequest request) {
            print("Navigation request to: ${request.url}"); // Debug URL
            _handleUrl(request.url);
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.iframeUrl));
  }

  void _handleUrl(String url) {
    print("Handling URL: $url"); // Debug URL

    if (url.contains("success=true")) {
      print("Detected success in URL."); // Debug success detection
      Navigator.pop(context, true);
      _showDialog("Payment Successful", "Your order has been placed.");
    } else if (url.contains("success=false")) {
      print("Detected failure in URL."); // Debug failure detection
      Navigator.pop(context, false);
      _showDialog("Payment Failed", "Please try again.");
    } else {
      print("No success or failure detected in URL."); // Debug fallback
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paymob Payment'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
