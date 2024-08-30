// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'info.dart';
// import 'nfc.dart';
//
// class VietnamIdCardNfcReaderPage extends StatefulWidget {
//   @override
//   _VietnamIdCardNfcReaderPageState createState() => _VietnamIdCardNfcReaderPageState();
// }
//
// class _VietnamIdCardNfcReaderPageState extends State<VietnamIdCardNfcReaderPage> {
//   final _nfcReader = VietnamIdCardNfcReader();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('NFC ID Card Reader'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _readNFCTag,
//           child: Text('Read ID Card'),
//         ),
//       ),
//     );
//   }
//
//   Future<void> _readNFCTag() async {
//     try {
//       final nfcData = await _nfcReader.readNFCTag();
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => NFCContentPage(),
//           settings: RouteSettings(
//             arguments: nfcData,
//           ),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error reading NFC tag: $e'),
//         ),
//       );
//     }
//   }
//   Future<String> readNFCTag() async {
//     // Code for reading NFC tag and returning the data
//     return 'NFC Tag Data';
//   }
// }