import 'package:code/elements/frame_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../elements/lightning_gallery.dart';
import '../../styles/app_colors.dart';
import 'info_screen.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
  // CameraController? _controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrController;
  bool scannedSuccessfully = false;

  ///
  // late final MobileScannerController mobileScanner;

  @override
  void initState() {
    super.initState();

    //_initializeCamera();
    // //
    // mobileScanner = MobileScannerController(
    //     torchEnabled: false,
    //   // cameraResolution:
// );
  }

  // Future<void> _initializeCamera() async {
  //   final cameras = await availableCameras();
  //   if (cameras.isNotEmpty) {
  //     _controller = CameraController(
  //         cameras[0], ResolutionPreset.high);
  //     await _controller!.initialize();
  //     setState(() {});
  //   } else {
  //     print('Không tìm thấy camera.');
  //   }
  // }

  @override
  void dispose() {
    qrController?.dispose();
    //_controller?.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    this.qrController = controller;

    qrController?.scannedDataStream.listen((scanData) {
      if (scanData.code != null && !scannedSuccessfully) {
        scannedSuccessfully = true;
        qrController?.pauseCamera();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoScreen(data: scanData.code!),
          ),
        );
      }
    }, onError: (error) {
      print('Lỗi quét mã QR: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Đảm bảo QRView chiếm toàn bộ không gian
            Positioned.fill(
              child: QRView(
                key: qrKey,
                onQRViewCreated: onQRViewCreated,
              ),
            ),
            FrameCamera(), // FrameCamera vẫn nằm trên QRView
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
