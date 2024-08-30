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
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.lightBlue,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)), // Bo tròn chỉ phía trên
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: [
          _buildButton('assets/logo/groupbtn/thong_tin.svg', 'Thông tin phương tiện', () {
            // Handle action for Button 1
          }),
          _buildButton('assets/logo/groupbtn/giay_phep.svg', 'Giấy phép lái xe', () {
            // Handle action for Button 2
          }),
          _buildButton('assets/logo/groupbtn/phat_nguoi.svg', 'Tra cứu phạt nguội', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SanctionDetail(
                  plateNo: plateNo,
                ),
              ),
            );
          }),
          _buildButton('assets/logo/groupbtn/dk_xe.svg', 'Giấy chứng nhận ĐK xe', () {
            // Handle action for Button 4
          }),
        ],
      ),
    );
  }

  Widget _buildButton(String iconPath, String label, VoidCallback onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          padding: EdgeInsets.only(top: 10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 70,
              height: 70,
            ),
            SizedBox(height: 10), // Increase spacing between icon and label
            Text(
              label,
              style: TextStyle(color: Colors.black, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}