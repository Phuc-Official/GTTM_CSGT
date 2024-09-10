import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class InfoScreen extends StatelessWidget {
  final String data;
  final String imagePath;
  const InfoScreen({Key? key, required this.data, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> lines = data.split('|');
    List<String> formattedLines = [];

    Future<List<String>> _scanQRCode() async {
      final inputImage = InputImage.fromFilePath(imagePath);
      final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
      final barcodes = await barcodeScanner.processImage(inputImage);

      for (var barcode in barcodes) {
        String? qrCodeValue = barcode.rawValue;
        if (qrCodeValue != null) {
          return qrCodeValue.split('|'); // Convert QR code value to list
        }
      }
      return [];
    }

    void formatLines(List<String> linesToFormat) {
      for (int i = 0; i < linesToFormat.length; i++) {
        String line = linesToFormat[i];
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
              String formattedDate =
                  '${line.substring(0, 2)}/${line.substring(2, 4)}/${line.substring(4, 8)}';
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
            if (int.tryParse(line) != null) {
              String formattedDate =
                  '${line.substring(0, 2)}/${line.substring(2, 4)}/${line.substring(4, 8)}';
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
    }

    // Format the original lines only if data is not empty
    if (data.isNotEmpty) {
      formatLines(lines);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin quét được'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(Navigator.defaultRouteName));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (formattedLines.isNotEmpty) ...[
              for (String line in formattedLines)
                Text(
                  line,
                  style: TextStyle(fontSize: 20),
                ),
            ],
            const SizedBox(height: 16),
            FutureBuilder<List<String>>(
              future: _scanQRCode(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  final qrCodeLines = snapshot.data!;
                  if (qrCodeLines.isNotEmpty) {
                    formatLines(qrCodeLines); // Format the QR code lines
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (String line in formattedLines)
                          Text(
                            line,
                            style: TextStyle(fontSize: 20),
                          ),
                      ],
                    );
                  }
                  // Return nothing if qrCodeLines is empty
                  return Container();
                }
                // Return nothing if snapshot has no data
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
