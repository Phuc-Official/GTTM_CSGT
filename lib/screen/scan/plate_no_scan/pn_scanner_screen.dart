import 'package:camera/camera.dart';
import 'package:code/elements/frame_camera.dart';
import 'package:code/elements/lightning_gallery.dart';
import 'package:code/screen/scan/plate_no_scan/plate_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  List<CameraDescription> cameras = <CameraDescription>[];
  bool _isCameraInitialized = false;

  // Khung quét
  final Rect scanRect =
      Rect.fromLTWH(250, 430, 10, 250); // Tọa độ của khung quét

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        // Sử dụng ResolutionPreset.max để tăng chất lượng camera
        _controller = CameraController(cameras.first, ResolutionPreset.high);
        _initializeControllerFuture = _controller!.initialize();
        await _initializeControllerFuture;
        setState(() {
          _isCameraInitialized = true;
        });
      } else {
        throw Exception('Không tìm thấy camera.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khởi tạo camera: $e')),
      );
    }
  }

  Future<void> _detectText() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller!.takePicture();
      if (image.path.isNotEmpty) {
        final inputImage = InputImage.fromFilePath(image.path);
        final textDetector = GoogleMlKit.vision.textRecognizer();
        final RecognizedText recognizedText =
            await textDetector.processImage(inputImage);

        // Kiểm tra nếu văn bản nằm trong khung quét
        List<String> textsInFrame = _getTextsInFrame(recognizedText);

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
            SnackBar(
                content: Text('Không phát hiện văn bản nào trong khung quét.')),
          );
        }
      }
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi quét văn bản: $e')),
      );
    }
  }

  List<String> _getTextsInFrame(RecognizedText recognizedText) {
    List<String> textsInFrame = [];
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        final lineRect = line.boundingBox;

        // Kiểm tra xem dòng có nằm trong khung quét không
        if (lineRect != null && scanRect.overlaps(lineRect)) {
          textsInFrame.add(line.text);
        }
      }
    }
    return textsInFrame;
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      await _initializeCamera();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cần quyền truy cập camera.')),
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _isCameraInitialized
              ? FutureBuilder<void>(
                  future: _initializeControllerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return CameraPreview(_controller!);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : Center(child: CircularProgressIndicator()),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text(
                'Quét biển số',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
            ),
          ),
          FrameCamera(),
          Positioned(
            bottom: 60,
            left: MediaQuery.of(context).size.width / 2 - 28,
            child: FloatingActionButton(
              onPressed: _detectText,
              child: Icon(Icons.camera),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 150),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlashAndGalleryButtons(cameraController: _controller),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
