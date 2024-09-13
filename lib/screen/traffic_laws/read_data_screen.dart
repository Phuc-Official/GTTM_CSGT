import 'package:flutter/material.dart';

class ExcelReader extends StatelessWidget {
  final List<String> data;
  final String vehicleType; // Thêm biến này
  final String violationType; // Thêm biến này

  ExcelReader(
      {required this.data,
      required this.vehicleType,
      required this.violationType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết vi phạm'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '$vehicleType > $violationType',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data[index]
                        .split('\n') // Tách dữ liệu thành các dòng
                        .map<Widget>((line) {
                      return Text(
                        line,
                        style: TextStyle(
                          color: line.contains('Mức phạt tối đa')
                              ? Colors.red
                              : Colors.black,
                          fontWeight: line.contains('Mức phạt tối đa')
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
