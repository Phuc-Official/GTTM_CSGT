import 'dart:convert';

import 'package:code/data/vehicle.dart';
import 'package:http/http.dart' as http;
class VehicleService {
  final String apiUrl;

  VehicleService(this.apiUrl);

  Future<List<Vehicle>> fetchVehicles(String plateNo) async {
    final response = await http.get(Uri.parse('http://192.168.105.250:4113/traffic-violation/find-violation-by-plate-no/$plateNo'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) {
        return Vehicle(
          logId: item['LogId'],
          type: item['VehicleType'],
          plateNo: item['PlateNo'],
          iconPath: _getIconPath(item['VehicleType']),
        );
      }).toList();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  String _getIconPath(String vehicleType) {
    switch (vehicleType) {
      case 'Xe du lịch':
        return 'assets/logo/vehicle/classB1.svg';
      case 'Xe tải':
        return 'assets/logo/vehicle/classB2.svg';
      case 'Xe máy':
        return 'assets/logo/vehicle/classB3.svg';
      default:
        return 'assets/logo/vehicle/default.svg'; // Hình ảnh mặc định
    }
  }

  // Giả sử bạn đã có lớp VehicleService

  Future<List<String>> fetchPlateNumbers() async {
    final response = await http.get(Uri.parse('http://192.168.105.250:4113/traffic-violation/find-violation-by-plate-no/'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Kiểm tra xem dữ liệu có phải là đối tượng không và lấy danh sách
      if (data is Map && data.containsKey('LogId')) {
        return List<String>.from(data['LogId'].map((item) => item['PlateNo']));
      } else {
        throw Exception('Expected an object with plateNumbers but got ${data.runtimeType}');
      }
    } else {
      throw Exception('Failed to load plate numbers');
    }
  }
}