// import 'package:code/screen/lookup/sanction_detail.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../../api/api_violation.dart';
// import '../../button/horizontal_scroll.dart';
//
// class TrafficSanction extends StatefulWidget {
//   const TrafficSanction({super.key});
//
//   @override
//   _TrafficSanctionState createState() => _TrafficSanctionState();
// }
//
// class _TrafficSanctionState extends State<TrafficSanction> {
//   Map<String, dynamic>? violationData; // Dữ liệu vi phạm
//
//   void _updateViolationData(String plateNo) async {
//     final List<dynamic>? data = await findViolationByPlateNo(plateNo);
//     setState(() {
//       violationData = data != null && data.isNotEmpty ? data[0] : null;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Container(
//           alignment: Alignment.center,
//           child: Text(
//             'Thông tin phương tiện vi phạm',
//             style: TextStyle(fontSize: 18),
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         toolbarHeight: 60,
//       ),
//       body: Column(
//         children: [
//           HorizontalScroll(onVehicleSelected: _updateViolationData), // Truyền callback
//           SanctionDetail(violationData: violationData, plateNo: '',), // Truyền dữ liệu vi phạm
//         ],
//       ),
//     );
//   }
// }