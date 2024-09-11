import 'package:SmartTraffic/api/api_violation.dart';
import 'package:SmartTraffic/screen/scan/plate_no_scan/pn_scanner_screen.dart';
import 'package:SmartTraffic/screen/scan/qr_scan/qr_scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../styles/app_colors.dart';
import '../traffic_laws/laws_screen.dart';
import 'lookup_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.03),
            Center(
              child: Image.asset(
                'assets/logo/logo.png',
                height: screenHeight * 0.18,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              "Xin chào!",
              style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold), // Kích thước font responsive
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.17),
              child: Text(
                "Vui lòng nhập thông tin cần tra cứu hoặc quét mã QR, "
                "quẹt thẻ chip CCCD/CMND để tiếp tục quá trình.",
                style: TextStyle(
                    fontSize: screenWidth * 0.04, color: AppColors.bgOryza),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.06),
            Container(
              width: screenWidth * 0.85,
              height: screenHeight * 0.07,
              child: TextField(
                style: TextStyle(fontSize: screenWidth * 0.045),
                controller: _textController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "VD: 61A99XXX hoặc 61A-99XXX",
                  hintStyle: TextStyle(
                      color: Colors.black12, fontSize: screenWidth * 0.04),
                  labelText: 'Thông tin tra cứu',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: TextStyle(
                      color: Colors.grey, fontSize: screenWidth * 0.03),
                  floatingLabelStyle: const TextStyle(color: Colors.grey),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01, horizontal: 15),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildLookUpButton(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.08),
            _buildDivider(screenWidth), // Truyền screenWidth cho divider
            SizedBox(height: screenHeight * 0.05),
            _buildQRButton(
                screenWidth, screenHeight), // Truyền screenWidth cho nút
            SizedBox(height: screenHeight * 0.02),
            _buildNFCButton(
                screenWidth, screenHeight), // Truyền screenWidth cho nút
          ],
        ),
      ),
    );
  }

// Điều chỉnh các phương thức xây dựng cho nút và divider để nhận screenWidth
  Widget _buildDivider(double width) {
    return Container(
      width: width * 0.85, // 80% chiều rộng màn hình
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(child: Divider(color: Colors.grey, thickness: 0.2)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Hoặc',
                style: TextStyle(color: Colors.grey, fontSize: width * 0.035)),
          ),
          const Expanded(child: Divider(color: Colors.grey, thickness: 0.2)),
        ],
      ),
    );
  }

  Widget _buildQRButton(double width, double height) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => QRScan()));
      },
      child: Container(
        width: width * 0.85,
        height: height * 0.06,
        //padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blueTop, AppColors.blueBot],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/logo/scan.svg',
                width: width * 0.05, height: width * 0.05, color: Colors.white),
            SizedBox(width: 8),
            Text('Quét mã QR',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.04)),
          ],
        ),
      ),
    );
  }

  Widget _buildLookUpButton(double width, double height) {
    return GestureDetector(
      onTap: () {
        _checkViolation();
      },
      child: Container(
        width: width * 0.85,
        height: height * 0.06,
        //padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.orangeTop, AppColors.orangeBot],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Tra cứu',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.04)),
          ],
        ),
      ),
    );
  }

  Widget _buildNFCButton(double width, double height) {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => QrScannerPage()));
      // },
      child: Container(
        width: width * 0.85,
        height: height * 0.06,
        //padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.lightBlue, AppColors.lightBlue],
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/logo/signal.svg',
                width: width * 0.05,
                height: width * 0.05,
                color: AppColors.blueText),
            SizedBox(width: 8),
            Text('Quét thẻ NFC',
                style: TextStyle(
                    color: AppColors.blueText,
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.04)),
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

  Widget _buildTrafficLawsButton() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LawsScreen()));
      },
      child: Container(
        width: 145,
        height: 70,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset('assets/logo/signal.svg',
            //     width: 20, height: 20, color: AppColors.white),
            //SizedBox(width: 8),
            Text(
              'Luật \n giao thông',
              style: TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsButton() {
    return GestureDetector(
      // onTap: () {
      //   Navigator.push(
      //       context, MaterialPageRoute(builder: (context) => CameraPage()));
      // },
      child: Container(
        width: 145,
        height: 70,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.lightGreen],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SvgPicture.asset('assets/logo/signal.svg',
            //     width: 20, height: 20, color: AppColors.white),
            //SizedBox(width: 8),
            Text('Tin tức',
                style: TextStyle(
                    color: AppColors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

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
}
