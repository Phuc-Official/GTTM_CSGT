import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../data/vehicle.dart';
import '../data/vehicle_service.dart';
import '../styles/app_colors.dart';

class HorizontalScroll extends StatefulWidget {
  final Function(String) onVehicleSelected;

  const HorizontalScroll({Key? key, required this.onVehicleSelected}) : super(key: key);

  @override
  _HorizontalScrollState createState() => _HorizontalScrollState();
}

class _HorizontalScrollState extends State<HorizontalScroll> {
  int? selectedIndex;
  List<Vehicle> vehicles = [];
  bool isLoading = true;
  String currentPlateNo = ''; // Khởi tạo với giá trị mặc định

  @override
  void initState() {
    super.initState();
    _loadPlateNumbers(); // Gọi hàm để lấy biển số
  }

  Future<void> _loadPlateNumbers() async {
    final vehicleService = VehicleService('http://192.168.105.250:4113/traffic-violation');
    try {
      final plateNumbers = await vehicleService.fetchPlateNumbers();
      if (plateNumbers.isNotEmpty) {
        currentPlateNo = plateNumbers[0]; // Lấy biển số đầu tiên
        _loadVehicles(currentPlateNo); // Gọi phương thức để lấy xe
      } else {
        // Xử lý nếu không có biển số
        setState(() {
          isLoading = false; // Dừng loading nếu không có biển số
        });
      }
    } catch (e) {
      print('Error fetching plate numbers: $e');
      setState(() {
        isLoading = false; // Dừng loading khi có lỗi
      });
    }
  }

  Future<void> _loadVehicles(String plateNo) async {
    final vehicleService = VehicleService('http://192.168.105.250:4113/traffic-violation');
    try {
      final fetchedVehicles = await vehicleService.fetchVehicles(plateNo);
      setState(() {
        vehicles = fetchedVehicles;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching vehicles: $e');
      setState(() {
        isLoading = false; // Dừng loading khi có lỗi
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: vehicles
              .asMap()
              .entries
              .map((entry) {
            int index = entry.key;
            Vehicle vehicle = entry.value;
            return _buildButton(
              index,
              vehicle.iconPath,
              vehicle.plateNo,
                  () {
                setState(() {
                  selectedIndex = index;
                });
                widget.onVehicleSelected(vehicle.logId); // Gọi callback với logId
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildButton(int index, String iconPath, String label, VoidCallback onPressed) {
    bool isSelected = selectedIndex == index;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.blueText : AppColors.bgVehicle,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          minimumSize: Size(57, 27),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 18,
              height: 18,
              color: isSelected ? Colors.white : AppColors.divider,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.divider,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}