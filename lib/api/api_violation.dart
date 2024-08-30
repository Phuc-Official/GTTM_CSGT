import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



import 'dart:convert'; // Đảm bảo rằng bạn đã import thư viện json
import 'package:http/http.dart' as http;


Future<List<Map<String, dynamic>>> fetchViolations(String plateNo) async {
  final String baseUrl = 'http://192.168.105.250:4113'; // Khởi tạo baseUrl
  final String url = '$baseUrl/traffic-violation/find-violation-by-plate-no/$plateNo';
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((violation) => Map<String, dynamic>.from(violation)).toList();
    } else {
      print('Lỗi: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Đã xảy ra lỗi: $e');
    return [];
  }
}

Future<dynamic> findViolationByPlateNo(String plateNo) async {
  final String url = 'http://192.168.105.250:4113/traffic-violation/find-violation-by-plate-no/$plateNo';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Kiểm tra nếu có dữ liệu trả về
      if (data.isEmpty) {
        return []; // Trả về danh sách rỗng nếu không có vi phạm
      } else {
        List<Map<String, dynamic>> list = data.map((e) => Map<String, dynamic>.from(e)).toList();
        print('Danh sách vi phạm: $list');
        return list; // Trả về danh sách dữ liệu
      }
    } else if (response.statusCode == 404) {
      // Nếu không tìm thấy dữ liệu, trả về số 1
      print('Không tìm thấy biển số.');
      return 1; // Trả về số 1 nếu không tìm thấy
    } else {
      print('Lỗi: ${response.statusCode}');
      return []; // Trả về danh sách rỗng nếu có lỗi khác
    }
  } catch (e) {
    print('Đã xảy ra lỗi: $e');
    return []; // Trả về danh sách rỗng nếu có ngoại lệ
  }
}
// Future<List<dynamic>?> findAllViolations(String plateNo) async {
//   final String url = 'http://192.168.105.250:4113/traffic-violation/find-violation-by-plate-no/$plateNo'; // Thay thế bằng URL API thực tế
//
//   try {
//     final response = await http.get(Uri.parse(url));
//
//     // Kiểm tra nếu API trả về thành công (HTTP 200)
//     if (response.statusCode == 200) {
//       // Phân tích dữ liệu JSON và trả về dưới dạng danh sách
//       return json.decode(response.body);
//     } else {
//       // Xử lý khi API trả về lỗi
//       print('Error: ${response.statusCode}');
//       return null;
//     }
//   } catch (e) {
//     // Xử lý lỗi khi gọi API
//     print('Error fetching violations: $e');
//     return null;
//   }
// }