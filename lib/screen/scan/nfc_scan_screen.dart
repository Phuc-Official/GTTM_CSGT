// import 'package:flutter/material.dart';
// import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
//
// import 'info_screen.dart';
//
//
// class NFCScanner extends StatefulWidget {
//   const NFCScanner({Key? key});
//
//   @override
//   State<NFCScanner> createState() => _NFCScannerState();
// }
//
// class _NFCScannerState extends State<NFCScanner> {
//   String nfcId = '';
//   bool scannedSuccessfully = false;
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   void onNFCScanned(NFCTag tag) {
//     if (!scannedSuccessfully) {
//       scannedSuccessfully = true;
//       setState(() {
//         nfcId = tag.id; // Lưu ID của thẻ NFC
//       });
//       // Chuyển sang trang Info với ID của thẻ NFC
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => InfoScreen(data: nfcId),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Quét NFC')),
//       body: Stack(
//         children: [
//           NFCListener(onNFCScanned: onNFCScanned),
//           // Hướng dẫn
//           Positioned(
//             top: 50,
//             left: 0,
//             right: 0,
//             child: Container(
//               padding: const EdgeInsets.all(16.0),
//               color: Colors.black54,
//               child: Text(
//                 'Di chuyển thẻ NFC vào vùng quét!',
//                 style: TextStyle(color: Colors.white),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class NFCListener extends StatefulWidget {
//   final Function(NFCTag) onNFCScanned;
//
//   const NFCListener({required this.onNFCScanned, Key? key}) : super(key: key);
//
//   @override
//   _NFCListenerState createState() => _NFCListenerState();
// }
//
// class _NFCListenerState extends State<NFCListener> {
//   late NFCTag? _tag;
//
//   @override
//   void initState() {
//     super.initState();
//     _initNFCScan();
//   }
//
//   Future<void> _initNFCScan() async {
//     try {
//       NFCTag? tag = await FlutterNfcKit.poll();
//       if (tag != null) {
//         widget.onNFCScanned(tag);
//       }
//     } catch (e) {
//       print('Lỗi quét NFC: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(); // Không hiển thị giao diện của widget này
//   }
// }