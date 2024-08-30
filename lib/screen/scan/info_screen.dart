import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  final String data;

  const InfoScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> lines = data.split('|');
    List<String> formattedLines = [];

    // Format the date fields and add additional information
    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];
      switch (i) {
        case 0:
          formattedLines.add('Số CCCD: $line');
          break;
        case 1:
          formattedLines.add('Số CMT: $line');
          break;
        case 2:
          formattedLines.add('Họ và tên: $line');
          break;
        case 3:
          if (line.length == 8 && int.tryParse(line) != null) {
            String formattedDate = '${line.substring(0, 2)}/${line.substring(2, 4)}/${line.substring(4, 8)}';
            formattedLines.add('Ngày sinh: $formattedDate');
          } else {
            formattedLines.add('Ngày sinh: $line');
          }
          break;
        case 4:
          formattedLines.add('Giới tính: $line');
          break;
        case 5:
          formattedLines.add('Địa chỉ: $line');
          break;
        case 6:
          if (line.length == 8 && int.tryParse(line) != null) {
            String formattedDate = '${line.substring(0, 2)}/${line.substring(2, 4)}/${line.substring(4, 8)}';
            formattedLines.add('Ngày lập: $formattedDate');
          } else {
            formattedLines.add('Ngày lập: $line');
          }
          break;
        default:
          formattedLines.add(line);
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin quét được'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Quay lại trang Home
            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (String line in formattedLines)
              Text(
                line,
                style: TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}