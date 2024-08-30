// import 'dart:convert';
// import 'package:nfc_manager/nfc_manager.dart';
//
// class VietnamIdCardNfcReader {
//   bool _isNFCAvailable = false;
//   bool _isReadingNFC = false;
//   String _nfcData = '';
//
//   /// Check if NFC is available on the device
//   Future<bool> checkNFCAvailability() async {
//     _isNFCAvailable = await NfcManager.instance.isAvailable();
//     return _isNFCAvailable;
//   }
//
//   /// Start reading the NFC tag (Vietnamese ID card)
//   Future<void> startNFCReading() async {
//     if (!_isNFCAvailable) {
//       throw Exception('NFC is not available on this device.');
//     }
//
//     if (_isReadingNFC) {
//       throw Exception('NFC reading is already in progress.');
//     }
//
//     _isReadingNFC = true;
//
//     try {
//       await NfcManager.instance.startSession(
//         onDiscovered: (NfcTag tag) async {
//           final ndef = Ndef.from(tag);
//           if (ndef == null) {
//             print('Tag is not NDEF formatted');
//             await NfcManager.instance.stopSession();
//             _isReadingNFC = false;
//             return;
//           }
//
//           final ndefMessage = await ndef.read();
//           for (final record in ndefMessage.records) {
//             if (record.typeNameFormat == NdefTypeNameFormat.nfcWellknown && record.type.toString() == 'id') {
//               final payload = record.payload;
//               final id = utf8.decode(payload.skip(1).toList());
//               _nfcData = id;
//               print('ID: $_nfcData');
//
//               // Extract other information from the ID card data
//               final name = _extractNameFromId(_nfcData);
//               final dateOfBirth = _extractDateOfBirthFromId(_nfcData);
//               final placeOfIssue = _extractPlaceOfIssueFromId(_nfcData);
//               print('Name: $name');
//               print('Date of Birth: $dateOfBirth');
//               print('Place of Issue: $placeOfIssue');
//             }
//           }
//
//           await NfcManager.instance.stopSession();
//           _isReadingNFC = false;
//         },
//       );
//     } catch (e) {
//       print('Error reading NFC tag: $e');
//       _isReadingNFC = false;
//       rethrow;
//     }
//   }
//
//   String _extractNameFromId(String id) {
//     // Implement logic to extract the name from the ID card data
//     return 'John Doe';
//   }
//
//   String _extractDateOfBirthFromId(String id) {
//     // Implement logic to extract the date of birth from the ID card data
//     return '1980-01-01';
//   }
//
//   String _extractPlaceOfIssueFromId(String id) {
//     // Implement logic to extract the place of issue from the ID card data
//     return 'Hanoi, Vietnam';
//   }
// }