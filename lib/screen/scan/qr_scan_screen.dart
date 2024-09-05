import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../styles/app_colors.dart';
import 'info_screen.dart';
import '../../button/lightning_gallery.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool scannedSuccessfully = false;
  bool isCameraActive = false; // Biến theo dõi trạng thái camera

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    if (!isCameraActive) {
      isCameraActive = true; // Đánh dấu camera đang hoạt động
      controller.scannedDataStream.listen((scanData) {
        if (scanData.code != null && !scannedSuccessfully) {
          scannedSuccessfully = true;
          controller.pauseCamera();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoScreen(data: scanData.code!),
            ),
          );
        }
      }, onError: (error) {
        print('Lỗi quét mã QR: $error'); // Xử lý lỗi quét
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quét mã QR')),
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
                  'Hướng camera về phía mã QR',
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlashAndGalleryButtons(),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 40.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        // Xử lý sự kiện khi button được nhấn
                      },
                      child: Container(
                        width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.blueTop, AppColors.blueBot],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/logo/signal.svg',
                              width: 20,
                              height: 20,
                              color: AppColors.white,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Quét thẻ NFC',
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}