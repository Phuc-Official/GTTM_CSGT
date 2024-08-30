import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../styles/app_colors.dart';
import 'info_screen.dart';
import '../../button/lightning_gallery.dart';

class PlateNoScan extends StatefulWidget {
  const PlateNoScan({Key? key}) : super(key: key);

  @override
  State<PlateNoScan> createState() => _PlateNoScanState();
}

class _PlateNoScanState extends State<PlateNoScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scannedSuccessfully = false;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData.code != null && !scannedSuccessfully) {
        scannedSuccessfully = true;
        controller.pauseCamera();

        if (_isValidLicensePlate(scanData.code!)) {
          // In dữ liệu ra log
          print('Biển số xe quét được: ${scanData.code!}');

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoScreen(data: scanData.code!), // Chuyển dữ liệu quét được đến InfoScreen
            ),
          ).then((_) {
            scannedSuccessfully = false; // Đặt lại trạng thái quét
            controller.resumeCamera(); // Tiếp tục quét
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Mã quét không phải là biển số xe hợp lệ!')),
          );
          scannedSuccessfully = false; // Cho phép quét lại
          controller.resumeCamera(); // Tiếp tục quét
        }
      }
    });
  }

  bool _isValidLicensePlate(String code) {
    // Kiểm tra định dạng biển số xe (bao gồm chữ, số, dấu '.' và '-')
    final RegExp regex = RegExp(r'^[A-Z0-9.-]{1,7}$');
    return regex.hasMatch(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quét biển số xe')),
      body: SafeArea(
        child: Stack(
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: onQRViewCreated,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80, top: 180),
                      child: SvgPicture.asset("assets/logo/expand.svg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 160, top: 180),
                      child: SvgPicture.asset("assets/logo/expand-1.svg"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 80, top: 180),
                      child: SvgPicture.asset("assets/logo/expand-2.svg"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 160, top: 180),
                      child: SvgPicture.asset("assets/logo/expand-3.svg"),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 100,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Quét biển số xe',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlashAndGalleryButtons(),
            ),
          ],
        ),
      ),
    );
  }
}