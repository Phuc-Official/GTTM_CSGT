import 'package:SmartTraffic/elements/frame_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../elements/flash&gallery_qrscan.dart';
import '../../../styles/app_colors.dart';
import 'info_screen.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  bool scannedSuccessfully = false;
  bool isTorchOn = false;

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    this.qrController = controller;

    qrController?.scannedDataStream.listen(
      (scanData) {
        if (scanData.code != null && !scannedSuccessfully) {
          scannedSuccessfully = true;
          qrController?.pauseCamera();
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoScreen(
                data: scanData.code!,
                imagePath: '',
              ),
            ),
          );
        }
      },
    );
  }

  void toggleFlash() {
    if (qrController != null) {
      setState(() {
        isTorchOn = !isTorchOn;
      });
      qrController?.toggleFlash();
      print('Đèn pin ${isTorchOn ? 'bật' : 'tắt'}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: QRView(
                key: qrKey,
                onQRViewCreated: onQRViewCreated,
              ),
            ),
            FrameCamera(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                title: Text(
                  'Quét mã QR',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.white),
              ),
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
                FGButtonsQrScan(
                    onToggleFlash: toggleFlash), // Truyền hàm toggleFlash
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 15),
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
