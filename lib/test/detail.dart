import 'package:code/api/api_violation.dart';
import 'package:code/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class SanctionDetail extends StatefulWidget {
  final String plateNo; // Biển số xe
  final Map<String, dynamic>? violationData; // Dữ liệu vi phạm

  const SanctionDetail({super.key, required this.plateNo, this.violationData});

  @override
  _SanctionDetailState createState() => _SanctionDetailState();
}

class _SanctionDetailState extends State<SanctionDetail> {
  bool _isPressed = false; // Trạng thái nút

  void _toggleButton() {
    setState(() {
      _isPressed = true; // Đặt trạng thái nút là đã nhấn
    });

    (
    Duration(milliseconds: 200),
        () {
      setState(() {
        _isPressed = false; // Quay lại trạng thái ban đầu
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 5, left: 20, right: 20),
      child: Container(
        width: double.infinity, // Chiều rộng linh hoạt
        decoration: BoxDecoration(
          color: AppColors.lightBlue, // Màu nền
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(1, 3),
            ),
          ],
        ),
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.violationData != null) ...[
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
                    padding:
                    EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
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
              SizedBox(height: 10),
              _buildInfoRow('Loại vi phạm', _getViolationType()),
              SizedBox(height: 20),
              _buildInfoRow('Lỗi vi phạm', _getViolationError()),
              SizedBox(height: 20),
              _buildInfoRow('Thời gian vi phạm',
                  _formatDateTime(widget.violationData?['LogId']['Time'])),
              SizedBox(height: 20),
              _buildInfoRow('Địa điểm vi phạm',
                  widget.violationData?['LogId']['LocationViolation'] ?? '-- '),
              SizedBox(height: 20),
              _buildInfoRow('Toạ độ vi phạm',
                  widget.violationData?['LogId']['Coordinate'] ?? '-- '),
              SizedBox(height: 20),
              _buildInfoRow('Đơn vị phát hiện\nvi phạm',
                  widget.violationData?['LogId']['SettlementAgency'] ?? '-- '),
              SizedBox(height: 20),
              _buildLicenseStatusRow(),
// Thay thế hiển thị giấy phép lái xe
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
            ] else ...[
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                // Thêm padding xung quanh văn bản
                child: Text(
                  'Chưa có thông tin',
                  style: TextStyle(
                      fontSize: 12,
                      color: AppColors.blueBot,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ],
        ),
      ),
    );
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
          decoration: BoxDecoration(
            color: AppColors.orangeBot, // Màu nền cho trạng thái giấy phép
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _getLicenseStatus(),
            style: TextStyle(
                fontSize: 10,
                color: AppColors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
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
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  String _getViolationType() {
    List<String> violations = [];
    if (widget.violationData?['LogId']['IsWrongLane'] == true) {
      violations.add('Đi sai làn');
    }
    if (widget.violationData?['LogId']['IsOverload'] == true) {
      violations.add('Quá tải');
    }
    if (widget.violationData?['LogId']['IsOversize'] == true) {
      violations.add('Quá kích thước');
    }

    return violations.isNotEmpty ? violations.join('\n') : '--  ';
  }

  String _getViolationError() {
    return widget.violationData?['LogId']['Error'] ?? '-- ';
  }

  String _getLicenseStatus() {
    return 'Đang bị tạm giữ'; // Trạng thái giấy phép lái xe
  }

  String _formatDateTime(String? dateTime) {
    if (dateTime == null) return '-- ';
    final DateTime parsedDate = DateTime.parse(dateTime);
    return DateFormat('HH:mm:ss dd/MM/yyyy').format(parsedDate);
  }

  void _printViolationData() {
    if (widget.violationData != null) {
      print("Dữ liệu vi phạm: ${widget.violationData}");
    } else {
      print("Không có dữ liệu vi phạm.");
    }
  }
}
