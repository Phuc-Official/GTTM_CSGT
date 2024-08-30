import 'package:code/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';

class FlashAndGalleryButtons extends StatefulWidget {
  @override
  _FlashAndGalleryButtonsState createState() => _FlashAndGalleryButtonsState();
}

class _FlashAndGalleryButtonsState extends State<FlashAndGalleryButtons> {
  final ImagePicker _picker = ImagePicker();
  bool _flashOn = false;
  CameraController? _cameraController;
  List<CameraDescription>? cameras;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();

    if (cameras!.isNotEmpty) {
      _cameraController = CameraController(
        cameras![0], // Sử dụng camera trước hoặc sau
        ResolutionPreset.medium,
      );

      await _cameraController?.initialize();
      setState(() {});
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('Đã chọn ảnh: ${pickedFile.path}');
    }
  }

  void _toggleFlash() {
    setState(() {
      _flashOn = !_flashOn;
      if (_cameraController != null && _cameraController!.value.isInitialized) {
        _cameraController!.setFlashMode(_flashOn ? FlashMode.torch : FlashMode.off);
      }
    });
    print('Flash ${_flashOn ? 'bật' : 'tắt'}');
  }

  @override
  void dispose() {
    _cameraController?.dispose();
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
                onTap: _toggleFlash,
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
                        color: _flashOn ? Colors.blue : Colors.white,
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: Text(
                          _flashOn ? 'Tắt đèn pin' : 'Bật đèn pin',
                          style: TextStyle(
                            color: _flashOn ? Colors.blue : Colors.white,
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