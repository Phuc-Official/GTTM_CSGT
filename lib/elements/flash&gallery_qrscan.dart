import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../styles/app_colors.dart';
import '../screen/scan/qr_scan/info_screen.dart';

class FGButtonsQrScan extends StatefulWidget {
  final Function() onToggleFlash; // Hàm callback để bật tắt đèn pin

  FGButtonsQrScan({required this.onToggleFlash});

  @override
  _FGButtonsQrScanState createState() => _FGButtonsQrScanState();
}

class _FGButtonsQrScanState extends State<FGButtonsQrScan> {
  final ImagePicker _picker = ImagePicker();
  bool isTorchOn = false; // Trạng thái đèn pin
  bool _isPickingImage = false;

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
                onTap: () {
                  setState(() {
                    isTorchOn = !isTorchOn; // Cập nhật trạng thái đèn pin
                  });
                  widget.onToggleFlash(); // Gọi hàm callback khi nhấn
                },
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
                        color: isTorchOn
                            ? Colors.blue
                            : Colors.white, // Đổi màu icon
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: Text(
                          isTorchOn ? 'Tắt đèn pin' : 'Bật đèn pin',
                          style: TextStyle(
                            color: isTorchOn
                                ? Colors.blue
                                : Colors.white, // Đổi màu chữ
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
