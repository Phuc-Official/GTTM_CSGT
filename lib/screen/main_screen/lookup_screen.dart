import 'package:code/styles/app_colors.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin tra cứu'),
      ),
      body: ListView(
        // Sử dụng ListView
        children: [
          Center(
            child: Image.asset(
              'assets/logo/frameCCCD.png',
              width: 330,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  // Hành động khi nhấn nút
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.greyBtn,
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 10), // Further reduced padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Keep it as is
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/logo/id-card.svg',
                      width: 20,
                      height: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 15), // Reduced space between icon and text
                    Text(
                      'Thông tin chi tiết',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          ButtonGrid(
            plateNo: plateNo, // Truyền biển số vào ButtonGrid
          ),
        ],
      ),
    );
  }
}
