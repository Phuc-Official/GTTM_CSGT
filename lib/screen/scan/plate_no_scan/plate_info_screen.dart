import 'package:flutter/material.dart';

import '../../main_screen/lookup_screen.dart'; // Đảm bảo import LookupScreen

class InfoPage extends StatelessWidget {
  final String extractedText;

  InfoPage({required this.extractedText});

  @override
  Widget build(BuildContext context) {
    // Gộp các dòng thành một dòng và loại bỏ dấu chấm
    String singleLineText =
        extractedText.replaceAll('\n', '-').replaceAll('.', '');

    return Scaffold(
      appBar: AppBar(title: Text('Thông Tin')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              singleLineText.isNotEmpty ? singleLineText : 'Không có văn bản.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (singleLineText.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LookupScreen(plateNo: singleLineText),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Không có văn bản để tra cứu.')),
                  );
                }
              },
              child: Text('Xem Thông Tin Vi Phạm'),
            ),
          ],
        ),
      ),
    );
  }
}
