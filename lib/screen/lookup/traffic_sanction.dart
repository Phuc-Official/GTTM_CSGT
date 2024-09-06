import 'package:code/screen/lookup/sanction_detail.dart';
import 'package:flutter/material.dart';

import '../../elements/horizontal_scroll.dart';

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
          HorizontalScroll(onVehicleSelected: (String plateNo) {
            // Cập nhật dữ liệu vi phạm nếu cần
            // Có thể gọi API để lấy dữ liệu vi phạm cho biển số được chọn
          }),
          SanctionDetail(
            plateNo: widget.plateNo, // Truyền biển số xe
            // Không cần truyền violationData
          ),
        ],
      ),
    );
  }
}
