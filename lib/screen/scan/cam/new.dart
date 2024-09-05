import 'package:code/screen/scan/cam/plate_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
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

  @override
  void initState() {
    _requestCameraPermission();
    // _initializeCamera();
    super.initState();

  }

  void _handleCameraError() {
    _controller?.dispose();
    //_initializeCamera(); // Khởi động lại camera
  }

  Future<void> _initializeCamera() async {
    try {
      cameras = await availableCameras();
      if (cameras.isNotEmpty) {
        _controller = CameraController(cameras.first, ResolutionPreset.high);
        _initializeControllerFuture = _controller!.initialize();
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
      await _handleCameraError;
      await _initializeControllerFuture;
      final image = await _controller!.takePicture(); //// Null check
      // print(image.toString());
      if(image != null) {
        final inputImage = InputImage.fromFilePath(image.path);
        final textDetector = GoogleMlKit.vision.textRecognizer(); // Sử dụng textRecognizer
        final RecognizedText recognizedText = await textDetector.processImage(inputImage);

        String text = recognizedText.text;

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InfoPage(extractedText: text),
          ),
        );
      }


    } catch (e) {
      print(e.toString());
    }

  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }
    if (status.isGranted) {
      await _initializeCamera(); // Khởi tạo camera nếu có quyền
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Cần quyền truy cập camera.')),
      );
    }
  }

  // Future<void> _requestCameraPermission() async {
  //   var status = await Permission.camera.status;
  //   if (!status.isGranted) {
  //     await Permission.camera.request();
  //   }
  // }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller!);
          } else {
// Hiển thị loading hoặc thông báo
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _detectText,
        child: Icon(Icons.camera),
      ),
    );
  }
}