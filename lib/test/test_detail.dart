// import 'package:code/styles/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class SanctionDetail extends StatefulWidget {
//   final String plateNo; // Biển số xe
//
//   const SanctionDetail({super.key, required this.plateNo, List<Map<String, dynamic>>? violationData});
//
//   @override
//   State<SanctionDetail> createState() => _SanctionDetailState();
// }
//
// class _SanctionDetailState extends State<SanctionDetail> {
//
//   bool _isPressed = false; // Trạng thái nút
//
//   void _toggleButton() {
//     setState(() {
//       _isPressed = true; // Đặt trạng thái nút là đã nhấn
//     });
//
//     (
//     Duration(milliseconds: 200),
//         () {
//       setState(() {
//         _isPressed = false; // Quay lại trạng thái ban đầu
//       });
//     }
//     );
//   }
//
//   Future<List<Map<String, dynamic>>> fetchViolations() async {
//     final String url = 'http://192.168.105.250:4113/traffic-violation/find-violation-by-plate-no/${widget.plateNo}';
//
//     print(url);
//     try {
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         return data.map((e) => Map<String, dynamic>.from(e)).toList();
//       } else {
//         print('Lỗi: ${response.statusCode}');
//         return [];
//       }
//     } catch (e) {
//       print('Đã xảy ra lỗi: $e');
//       return [];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thông tin phương tiện vi phạm'),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: AppColors.lightBlue,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 1,
//                 blurRadius: 5,
//                 offset: Offset(1, 3),
//               ),
//             ],
//           ),
//           padding: EdgeInsets.all(15),
//           child: FutureBuilder<List<Map<String, dynamic>>>(
//             future: fetchViolations(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Đã xảy ra lỗi: ${snapshot.error}'));
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return Center(child: Text('Không có thông tin vi phạm.'));
//               }
//
//               final violations = snapshot.data!;
//
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Thông tin phương tiện vi phạm',
//                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.blueBot),
//                   ),
//                   SizedBox(height: 10),
//                   // Lặp qua tất cả các vi phạm
//                   for (var violation in violations) ...[
//                     Text(_getName(violation)),
//
//                     _buildInfoRow('Loại vi phạm', _getViolationType(violation)),
//                     SizedBox(height: 10),
//                     _buildInfoRow('Lỗi vi phạm', violation['LogId']['Error'] ?? '-- '),
//                     SizedBox(height: 10),
//                     _buildInfoRow('Thời gian vi phạm', _formatDateTime(violation['LogId']['Time'])),
//                     SizedBox(height: 20), // Thêm khoảng cách giữa các vi phạm
//                   ],
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(String title, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 13, color: AppColors.divider),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             textAlign: TextAlign.right,
//             style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
//
//   String _getName(Map<String, dynamic> violation) {
//     return violation['ViolationPatternId']['Name'];
//
//   }
//
//   String _getViolationType(Map<String, dynamic> violation) {
//     print(violation['ViolationPatternId']['Name']);
//     List<String> violations = [];
//     if (violation['LogId']['IsWrongLane'] == true) {
//       violations.add('Đi sai làn');
//     }
//     if (violation['LogId']['IsOverload'] == true) {
//       violations.add('Quá tải');
//     }
//     if (violation['LogId']['IsOversize'] == true) {
//       violations.add('Quá kích thước');
//     }
//     return violations.isNotEmpty ? violations.join('\n') : '-- ';
//   }
//
//   String _formatDateTime(String? dateTime) {
//     if (dateTime == null) return '-- ';
//     final DateTime parsedDate = DateTime.parse(dateTime);
//     return DateFormat('HH:mm:ss dd/MM/yyyy').format(parsedDate);
//   }
// }
