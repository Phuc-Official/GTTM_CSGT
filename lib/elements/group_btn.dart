import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screen/lookup/sanction_detail.dart';
import '../styles/app_colors.dart';

class ButtonGrid extends StatelessWidget {
  final String plateNo; // Biển số xe

  const ButtonGrid({
    Key? key,
    required this.plateNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.only(top: 20, left: 0, right: 0),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(40), // Bo tròn chỉ phía trên
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround, // Căn giữa các nút
            children: [
              _buildButton(
                'assets/logo/groupbtn/thong_tin.svg',
                'Thông tin \n phương tiện',
                () {
                  // Handle action for Button 1
                },
                context,
                //buttonWidth: screenWidth * 0.0011,
                //buttonHeight: screenHeight * 0.00028,
                //margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                padding: EdgeInsets.only(
                    top: 1,
                    left: screenWidth * 0.020,
                    right: screenWidth * 0.010),
              ),
              _buildButton(
                'assets/logo/groupbtn/giay_phep.svg',
                'Giấy phép lái xe',
                () {
                  // Handle action for Button 2
                },
                context,
                //buttonWidth: screenWidth * 0.00109,
                //buttonHeight: screenHeight * 0.00028,
                //margin: EdgeInsets.only(),
                padding: EdgeInsets.only(
                    top: 1,
                    left: screenWidth * 0.001,
                    right: screenWidth * 0.020),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildButton(
                'assets/logo/groupbtn/phat_nguoi.svg',
                'Tra cứu \n phạt nguội',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SanctionDetail(
                        plateNo: plateNo,
                      ),
                    ),
                  );
                },
                context,
                //buttonWidth: screenWidth * 0.00109,
                //buttonHeight: screenHeight * 0.00028,
                //margin: EdgeInsets.only(),
                padding: EdgeInsets.only(
                    top: screenWidth * 0.050,
                    left: screenWidth * 0.020,
                    right: screenWidth * 0.001,
                    bottom: 35), // Padding riêng cho nút 3
              ),
              _buildButton(
                'assets/logo/groupbtn/dk_xe.svg',
                'Giấy chứng \n nhận ĐK xe',
                () {
                  // Handle action for Button 4
                },
                context,
                //buttonWidth: screenWidth * 0.00109,
                //buttonHeight: screenHeight * 0.00028,
                //margin: EdgeInsets.only(),
                padding: EdgeInsets.only(
                    top: screenWidth * 0.050,
                    left: screenWidth * 0.001,
                    right: screenWidth * 0.020,
                    bottom: 35), // Padding riêng cho nút 4
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    String iconPath,
    String label,
    VoidCallback onPressed,
    BuildContext context, {
    //required double buttonWidth,
    //required double buttonHeight,
    //required EdgeInsetsGeometry margin,
    required EdgeInsetsGeometry padding, // Tham số padding riêng
  }) {
    // Lấy kích thước màn hình
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: padding, // Sử dụng padding đã truyền vào
      child: SizedBox(
        width: screenWidth * 0.43,
        height: screenHeight * 0.18,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: screenWidth * 0.16,
                height: screenWidth * 0.16,
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                label,
                style: TextStyle(
                    color: Colors.black, fontSize: screenHeight * 0.018),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
