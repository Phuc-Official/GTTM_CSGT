import 'package:SmartTraffic/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../api/api_violation.dart';

/// Xem chi tiết phạt nguội

class SanctionDetail extends StatefulWidget {
  final String plateNo; // Biển số xe

  const SanctionDetail({super.key, required this.plateNo});

  @override
  State<SanctionDetail> createState() => _SanctionDetailState();
}

class _SanctionDetailState extends State<SanctionDetail> {
  bool _isPressed = false; // Trạng thái nút
  List<Map<String, dynamic>> vehicles = [];
  late String currentPlateNo;

  @override
  void initState() {
    super.initState();
    currentPlateNo = widget.plateNo;
    _fetchViolations(); // Khởi tạo biến với biển số xe ban đầu
  }

  void _toggleButton() {
    setState(() {
      _isPressed = true; // Đặt trạng thái nút là đã nhấn
    });

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _isPressed = false; // Quay lại trạng thái ban đầu
      });
    });
  }

  Future<void> _fetchViolations() async {
    List<Map<String, dynamic>> fetchedViolations =
        await fetchViolations(currentPlateNo);
    setState(() {
      vehicles = fetchedViolations; // Cập nhật danh sách vi phạm
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin phương tiện vi phạm',
            style: TextStyle(fontSize: 15)),
      ),
      body: Container(
        color: Colors.white, // Màu nền trắng cho toàn bộ body
        child: Stack(
          children: [
            // SingleChildScrollView bao bọc nội dung
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 55,
                    left: 20,
                    right: 20), // Tăng padding trên để tránh che
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),

                    // Hiển thị dữ liệu vi phạm
                    if (vehicles.isEmpty)
                      Center(child: Text('Không có thông tin vi phạm.'))
                    else
                      Column(
                        children: vehicles
                            .map((violation) =>
                                _buildViolationContainer(violation))
                            .toList(),
                      ),
                  ],
                ),
              ),
            ),

            // Widget biển số xe cố định
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(top: 00, left: 20, right: 20),
              child: _buildPlateNumberWidget(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlateNumberWidget() {
    return Container(
      margin: EdgeInsets.only(bottom: 0.5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.lightBlue, // Màu nền cho biển số
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(1, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Biển số xe:',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppColors.blueBot),
          ),
          Text(
            currentPlateNo,
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildViolationContainer(Map<String, dynamic> violation) {
    return Container(
      margin: EdgeInsets.only(bottom: 15), // Khoảng cách giữa các container
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      decoration: BoxDecoration(
        color: AppColors.lightBlue, // Màu nền cho từng container
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(1, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin phương tiện vi phạm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blueBot,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.bgDetail,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  'Chưa xử lý',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textDetail,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          _buildInfoRow('Loại vi phạm', _getViolationType(violation)),
          SizedBox(height: 20),
          _buildInfoRow(
              'Lỗi vi phạm', violation['ViolationPatternId']['Name'] ?? '-- '),
          SizedBox(height: 20),
          _buildInfoRow(
              'Thời gian vi phạm', _formatDateTime(violation['CreatedAt'])),
          SizedBox(height: 20),
          _buildInfoRow('Địa điểm vi phạm',
              violation['LogId']['LocationViolation'] ?? '-- '),
          SizedBox(height: 20),
          _buildInfoRow(
              'Toạ độ vi phạm', violation['LogId']['Coordinate'] ?? '-- '),
          SizedBox(height: 20),
          _buildInfoRow('Đơn vị phát hiện\nvi phạm',
              violation['LogId']['SettlementAgency'] ?? '-- '),
          SizedBox(height: 20),
          _buildLicenseStatusRow(),
          Align(
            alignment: Alignment.bottomLeft,
            child: TextButton(
              onPressed: () {
                _toggleButton();
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                backgroundColor: Colors.transparent,
              ),
              child: Row(
                children: [
                  Text(
                    'Xem giấy phép lái xe',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.blueBot,
                    ),
                  ),
                  SizedBox(width: 5),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    transform: _isPressed
                        ? Matrix4.translationValues(5, 0, 0)
                        : Matrix4.identity(),
                    child: SvgPicture.asset(
                      'assets/logo/CaretDoubleRight.svg',
                      width: 12,
                      height: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 13, color: AppColors.divider),
        ),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 90.0), // Khoảng cách bên trái
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.bold), // Cho phép xuống dòng
            ),
          ),
        ),
      ],
    );
  }

  String _getViolationType(Map<String, dynamic> violation) {
    List<String> violations = [];
    if (violation['LogId']['IsWrongLane'] == true) {
      violations.add('Đi sai làn');
    }
    if (violation['LogId']['IsOverload'] == true) {
      violations.add('Quá tải');
    }
    if (violation['LogId']['IsOversize'] == true) {
      violations.add('Quá kích thước');
    }
    return violations.isNotEmpty ? violations.join('\n') : '-- ';
  }

  String _formatDateTime(String? dateTime) {
    if (dateTime == null) return '-- ';
    final DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('HH:mm:ss dd/MM/yyyy').format(parsedDate);
  }

  Widget _buildLicenseStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Giấy phép lái xe',
          style: TextStyle(fontSize: 13, color: AppColors.divider),
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: AppColors.orangeBot, // Màu nền cho trạng thái giấy phép
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _getLicenseStatus(),
            style: TextStyle(
              fontSize: 10,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  String _getLicenseStatus() {
    return 'Đang bị tạm giữ'; // Trạng thái giấy phép lái xe
  }
}
