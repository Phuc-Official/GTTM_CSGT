import 'package:SmartTraffic/screen/lookup/sanction_detail.dart';
import 'package:flutter/material.dart';

class TrafficSanction extends StatefulWidget {
  final String plateNo; // Biển số xe

  const TrafficSanction({
    super.key,
    required this.plateNo,
  });

  @override
  _TrafficSanctionState createState() => _TrafficSanctionState();
}

class _TrafficSanctionState extends State<TrafficSanction> {
  @override
  void initState() {
    super.initState();
    // Không cần khai báo lại violationData
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin phương tiện vi phạm'),
      ),
      body: Column(
        children: [
          SanctionDetail(
            plateNo: widget.plateNo, // Truyền biển số xe
            // Không cần truyền violationData
          ),
        ],
      ),
    );
  }
}
