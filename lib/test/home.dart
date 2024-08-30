// import 'package:code/screen/lookup_screen.dart';
// import 'package:code/screen/scan/qr_scan_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gradient_button/flutter_gradient_button.dart';
// import 'package:flutter_svg/svg.dart';
// import '../button/divider.dart';
// import '../styles/app_colors.dart';
// import '../test/nfc.dart';
// import '../test/vn.dart';
// import 'scan/nfc_scan_screen.dart';
// import 'package:code/button/gradient.dart';
//
// class Home extends StatelessWidget {
//   TextEditingController _textController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         // Thêm SingleChildScrollView
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 30),
//             Center(
//               child: Image.asset(
//                 'assets/logo/logo.png',
//                 height: 130,
//               ),
//             ),
//             SizedBox(height: 30),
//             Text(
//               "Xin chào!",
//               style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               "Vui lòng nhập thông tin cần tra cứu \n "
//                   "hoặc quét mã QR, quẹt thẻ chip CCCD/ \n "
//                   "CMND để tiếp tục quá trình.",
//               textAlign: TextAlign.center,
//               style: TextStyle(color: AppColors.bgSecondaryLight),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.all(30),
//               child: TextField(
//                 controller: _textController,
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                   hintText: "VD: 61A99XXX hoặc 123456789XXX",
//                   hintStyle:
//                   TextStyle(color: AppColors.whiteOryza, fontSize: 15),
//                   labelText: 'Thông tin tra cứu',
//                   labelStyle: TextStyle(
//                     fontSize: 18,
//                     color: Colors.grey,
//                   ),
//                   floatingLabelBehavior: FloatingLabelBehavior.always,
//                   // Luôn hiển thị label
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.cyan,
//                       width: 1.0,
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(
//                       color: Colors.grey, // Đặt màu giống với focusedBorder
//                       width: 1.0,
//                     ),
//                     borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LookupScreen()),
//                 );
//               },
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 125, vertical: 15),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppColors.orangeTop, AppColors.orangeBot],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Text(
//                   'Tra cứu',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 55),
//             Container(
//               width: 300.0,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Divider(
//                       color: Colors.grey,
//                       thickness: 0.2,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       'Hoặc',
//                       style: TextStyle(
//                         color: Colors.grey,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Divider(
//                       color: Colors.grey,
//                       thickness: 0.2,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 40),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => QRScan()),
//                 );
//               },
//               child: Container(
//                 width: 300,
//                 padding: EdgeInsets.symmetric(vertical: 15),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppColors.blueTop, AppColors.blueBot],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       'assets/logo/scan.svg',
//                       width: 20,
//                       height: 20,
//                       color: Colors.white,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       'Quét mã QR',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             GestureDetector(
//               onTap: () {
// // Xử lý sự kiện khi button được nhấn
//               },
//               child: Container(
//                 width: 300,
//                 padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [AppColors.lightBlue, AppColors.lightBlue],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset(
//                       'assets/logo/signal.svg',
//                       width: 20,
//                       height: 20,
//                       color: AppColors.blueText,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       'Quét thẻ NFC',
//                       style: TextStyle(
//                         color: AppColors.blueText,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
