import 'package:flutter/material.dart';
import 'package:untitled/utils/app_color.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicy extends StatelessWidget {
   PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appColors,
        title: const Text("Privacy Policy"),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: "http://35.162.200.42/scanner_app/public/privacy-policy",
      )
    );
  }
}
