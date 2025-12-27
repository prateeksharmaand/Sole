import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sole/common/widgets/appbar/appbar.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final url = args?['url'] as String? ?? '';

    return Scaffold(
      appBar: UAppBar(title: const Text('Web View'), showBackArrow: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.web, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('Opening URL:'),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                url,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '(WebView implementation requires webview_flutter package)',
            ),
          ],
        ),
      ),
    );
  }
}
