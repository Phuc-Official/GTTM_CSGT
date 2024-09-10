import 'package:SmartTraffic/screen/scan/qr_scan/info_screen.dart';
import 'package:SmartTraffic/styles/app_colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class FlashAndGalleryButtons extends StatefulWidget {
  final CameraController? cameraController;

  FlashAndGalleryButtons({this.cameraController});

  @override
  _FlashAndGalleryButtonsState createState() => _FlashAndGalleryButtonsState();
}

class _FlashAndGalleryButtonsState extends State<FlashAndGalleryButtons> {
  final ImagePicker _picker = ImagePicker();
  bool isTorchOn = false;
  CameraController? _cameraController;
  List<CameraDescription>? cameras;
  bool _isPickingImage = false;

  ///
// late final MobileScannerController mobileScanner;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras![0], // Sử dụng camera trước hoặc sau
        ResolutionPreset.max,
      );

      await _cameraController?.initialize();
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    if (_isPickingImage) return; // Nếu đang chọn hình ảnh thì không làm gì cả
    _isPickingImage = true; // Đánh dấu rằng đang chọn hình ảnh

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // Điều hướng đến màn hình quét QR với hình ảnh đã chọn
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoScreen(
              imagePath: pickedFile.path,
              data: '',
            ),
          ),
        );
      }
    } catch (e) {
      print('Lỗi khi chọn hình ảnh: $e'); // In ra lỗi nếu có
    } finally {
      _isPickingImage = false; // Đánh dấu kết thúc chọn hình ảnh
    }
  }

// void _toggleFlash() {
// setState(() {
// isTorchOn = !isTorchOn;
// if (_cameraController != null && _cameraController!.value.isInitialized) {
// _cameraController!.setFlashMode(isTorchOn ? FlashMode.torch : FlashMode.off);
// }
// });
// //print('Flash ${isTorchOn ? 'bật' : 'tắt'}');
// }

  Future<void> _toggleTorch() async {
    if (isTorchOn) {
      await _disableTorch();
    } else {
      await _enableTorch();
    }
  }

  Future<void> _enableTorch() async {
    try {
      await widget.cameraController?.setFlashMode(FlashMode.torch);
      setState(() {
        isTorchOn = true;
      });
    } catch (e) {
      print('Lỗi khi bật đèn pin: $e');
    }
  }

  Future<void> _disableTorch() async {
    try {
      await widget.cameraController?.setFlashMode(FlashMode.off);
      setState(() {
        isTorchOn = false;
      });
    } catch (e) {
      print('Lỗi khi tắt đèn pin: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: AppColors.bgOryza.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _toggleTorch,
// onTap: () {
// setState(() {
// isTorchOn = !isTorchOn;
// mobileScanner.toggleTorch();
// });
// },
                child: Container(
                  width: 140,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/logo/lightning.svg',
                        width: 24,
                        height: 24,
                        color: isTorchOn ? Colors.blue : Colors.white,
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: Text(
                          isTorchOn ? 'Tắt đèn pin' : 'Bật đèn pin',
                          style: TextStyle(
                            color: isTorchOn ? Colors.blue : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 0.5,
                height: 65,
                color: Colors.black,
              ),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 140,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/logo/image.svg',
                        width: 24,
                        height: 24,
                        color: Colors.white,
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: Text(
                          'Tải ảnh lên',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
