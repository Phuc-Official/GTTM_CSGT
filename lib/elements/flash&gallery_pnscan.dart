import 'package:SmartTraffic/styles/app_colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import '../screen/scan/plate_no_scan/plate_info_screen.dart';

class FGButtonsPlateNoScan extends StatefulWidget {
  final CameraController? cameraController;

  FGButtonsPlateNoScan({this.cameraController});

  @override
  _FGButtonsPlateNoScanState createState() => _FGButtonsPlateNoScanState();
}

class _FGButtonsPlateNoScanState extends State<FGButtonsPlateNoScan> {
  final ImagePicker _picker = ImagePicker();
  bool isTorchOn = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('Đã chọn ảnh: ${pickedFile.path}');
      await _detectTextFromImage(
          pickedFile.path); // Gọi phương thức để đọc văn bản
    }
  }

  Future<void> _detectTextFromImage(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final textDetector = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognizedText =
          await textDetector.processImage(inputImage);

      // Lấy văn bản đã nhận diện
      List<String> textsInFrame = _getTexts(recognizedText);
      if (textsInFrame.isNotEmpty) {
        String extractedText = textsInFrame.join('\n');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoPage(extractedText: extractedText),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không phát hiện văn bản trong ảnh.')),
        );
      }
    } catch (e) {
      print('Lỗi khi quét văn bản: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi quét văn bản: $e')),
      );
    }
  }

  List<String> _getTexts(RecognizedText recognizedText) {
    List<String> textsInFrame = [];
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        textsInFrame.add(line.text);
      }
    }
    return textsInFrame;
  }

  Future<void> _toggleTorch() async {
    if (widget.cameraController != null &&
        widget.cameraController!.value.isInitialized) {
      if (isTorchOn) {
        await _disableTorch();
      } else {
        await _enableTorch();
      }
    } else {
      print('Camera chưa được khởi tạo.');
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
