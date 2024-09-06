import 'package:code/api/api_violation.dart';
import 'package:code/screen/scan/plate_no_scan/pn_scanner_screen.dart';
import 'package:code/screen/scan/qr_scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/app_colors.dart';
import 'lookup_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textController = TextEditingController();

  void _checkViolation() async {
    String plateNo = _textController.text.trim();
    if (plateNo.isNotEmpty) {
      final response = await findViolationByPlateNo(plateNo);

      // Kiểm tra nếu response là List
      if (response is List) {
        if (response.isEmpty) {
          // Nếu mảng rỗng, hiển thị thông báo không có vi phạm
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Bạn không có vi phạm nào.')),
          );
        } else {
          // Nếu có dữ liệu, chuyển đến LookupScreen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LookupScreen(plateNo: plateNo),
            ),
          );
        }
      } else if (response is int) {
        // Nếu trả về số 1, hiển thị thông báo không tìm thấy biển số
        if (response == 1) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không tìm thấy biển số.')),
          );
        } else {
          // Xử lý các giá trị số khác nếu cần
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi nhập liệu.')),
          );
        }
      } else {
        // Nếu response không phải List hoặc int, thông báo lỗi
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi nhập liệu.')),
        );
      }
    } else {
      // Thông báo nếu biển số xe trống
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vui lòng nhập biển số xe.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Center(
                child: Image.asset(
                  'assets/logo/logo.png',
                  height: 130,
                ),
              ),
              SizedBox(height: 30),
              const Text(
                "Xin chào!",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: TextField(
                  controller: _textController,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    hintText: "VD: 61A99XXX hoặc 61A-99XXX",
                    labelText: 'Thông tin tra cứu',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle:
                        TextStyle(color: Colors.black), // Màu label mặc định
                    floatingLabelStyle:
                        TextStyle(color: Colors.black), // Màu label khi focus
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.cyan, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _checkViolation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 125, vertical: 15),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.orangeTop, AppColors.orangeBot],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'Tra cứu',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 55),
              _buildDivider(),
              SizedBox(height: 40),
              _buildQRButton(),
              SizedBox(height: 15),
              _buildNFCButton(),
              SizedBox(height: 15),
              _buildPlateNoButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 300.0,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Divider(color: Colors.grey, thickness: 0.2)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Hoặc',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w400)),
          ),
          Expanded(child: Divider(color: Colors.grey, thickness: 0.2)),
        ],
      ),
    );
  }

  Widget _buildQRButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QRScan()));
      },
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(vertical: 15),
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
            SvgPicture.asset('assets/logo/scan.svg',
                width: 20, height: 20, color: Colors.white),
            SizedBox(width: 8),
            Text('Quét mã QR',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildNFCButton() {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => QrScannerPage()));
      },
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.lightBlue, AppColors.lightBlue],
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/logo/signal.svg',
                width: 20, height: 20, color: AppColors.blueText),
            SizedBox(width: 8),
            Text('Quét thẻ NFC',
                style: TextStyle(
                    color: AppColors.blueText, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildPlateNoButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CameraPage()));
      },
      child: Container(
        width: 300,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.orangeTop, AppColors.textDetail],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/logo/signal.svg',
                width: 20, height: 20, color: AppColors.white),
            SizedBox(width: 8),
            Text('Quét biển số xe',
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
