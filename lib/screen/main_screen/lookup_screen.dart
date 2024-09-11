import 'package:SmartTraffic/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../elements/group_btn.dart';

class LookupScreen extends StatelessWidget {
  final String plateNo; // Biển số xe

  const LookupScreen({
    super.key,
    required this.plateNo,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin tra cứu'),
      ),
      body: Column(
        // Thay ListView bằng Column
        children: [
          Expanded(
            flex: 5,
            // Sử dụng Expanded để chiếm không gian còn lại
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 00.0),
                    child: Container(
                      width: screenWidth,
                      child: Image.asset(
                        'assets/logo/frameCCCD.png',
                        width: screenHeight * 0.08,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 00),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Padding(
                    padding: EdgeInsets.symmetric(),
                    child: Container(
                      width: double.infinity, // Để Container rộng toàn bộ
                      child: ElevatedButton(
                        onPressed: () {
                          // Hành động khi nhấn nút
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.greyBtn,
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight * 0.0001, horizontal: 00),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28.0),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/logo/id-card.svg',
                              width: screenHeight * 0.02,
                              height: screenHeight * 0.02,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Thông tin chi tiết',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: screenHeight * 0.02,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 7,
            child: ButtonGrid(
              plateNo: plateNo, // Truyền biển số vào ButtonGrid
            ),
          ),
        ],
      ),
    );
  }
}
