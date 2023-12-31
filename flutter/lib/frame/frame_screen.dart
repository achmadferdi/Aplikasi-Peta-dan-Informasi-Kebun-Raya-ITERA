import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FrameScreen extends StatefulWidget {
  static const routeName = "frame";

  const FrameScreen({Key? key}) : super(key: key);

  @override
  State<FrameScreen> createState() => _FrameScreenState();
}

class _FrameScreenState extends State<FrameScreen> {
  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments as String;
    debugPrint("FRAME URL ::$data");
    return Scaffold(
      body: WebView(
        initialUrl: data,
        javascriptMode: JavascriptMode.unrestricted,
        onWebResourceError: (WebResourceError error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Tidak bisa terhubung'),
            backgroundColor: Colors.redAccent,
          ));
          Navigator.of(context).pop();
        },
      ),
    );
  }
}
