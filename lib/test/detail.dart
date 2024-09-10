import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class QRScanScreen extends StatelessWidget {
  final String imagePath;

  QRScanScreen({required this.imagePath});

  Future<String?> _scanQRCode() async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final barcodeScanner = GoogleMlKit.vision.barcodeScanner();
    final barcodes = await barcodeScanner.processImage(inputImage);

    for (var barcode in barcodes) {
      return barcode.rawValue; // Trả về giá trị mã QR đã quét
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quét mã QR')),
      body: FutureBuilder<String?>(
        future: _scanQRCode(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            final qrCodeValue = snapshot.data;
            return Center(
              child: Text(qrCodeValue != null
                  ? 'Mã QR: $qrCodeValue'
                  : 'Không tìm thấy mã QR.'),
            );
          } else {
            return Center(child: Text('Lỗi khi quét mã QR.'));
          }
        },
      ),
    );
  }
}
