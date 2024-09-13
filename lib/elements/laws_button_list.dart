import 'package:flutter/material.dart';

import '../screen/traffic_laws/read_data_screen.dart';

/// Nhóm nút trong xem luật giao thông

class LawsButtonList extends StatelessWidget {
  final List<Map<String, dynamic>> buttons;
  final String vehicleType; // Thêm biến này

  LawsButtonList({required this.buttons, required this.vehicleType});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
      ),
      itemCount: buttons.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExcelReader(
                  data: buttons[index]['data'],
                  vehicleType: vehicleType,
                  violationType: buttons[index]['label'],
                ),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.only(top: 15.0, left: 15, right: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: Icon(
                  buttons[index]['icon'],
                  color: Colors.white,
                  size: 35,
                ),
              ),
              Text(
                buttons[index]['label'],
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        );
      },
    );
  }
}
