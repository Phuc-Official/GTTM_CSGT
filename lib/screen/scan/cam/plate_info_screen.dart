import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  final String extractedText;

  InfoPage({required this.extractedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thông Tin')),
      body: Center(
        child: Text(
          extractedText.isNotEmpty ? extractedText : 'Không có văn bản.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}