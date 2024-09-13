// lib/laws_data.dart

import 'package:flutter/material.dart';

final List<Map<String, dynamic>> motorcycleButtons = [
  {
    'icon': Icons.speed,
    'label': 'Quá tốc độ',
    'data': [
      'Quá tốc độ từ 5 km/h đến dưới 10 km/h:\nMức phạt tối đa 300.000 đồng',
      'Quá tốc độ từ 10 km/h đến 20 km/h:\nMức phạt tối đa 1.000.000 đồng',
      'Quá tốc độ trên 20 km/h:\nMức phạt tối đa 5.000.000 đồng',
      'Quá tốc độ khi chạy thành nhóm từ 02 xe trở lên:\nMức phạt tối đa 8.000.000 đồng',
    ],
  },
  {
    'icon': Icons.local_drink,
    'label': 'Nồng độ cồn',
    'data': [
      'Nồng độ cồn trong máu hoặc hơi thở chưa vượt quá 50 miligam:\nMức phạt tối đa 3.000.000 đồng',
      'Nồng độ cồn từ 50 đến 80 miligam:\nMức phạt tối đa 5.000.000 đồng',
      'Nồng độ cồn trên 80 miligam:\nMức phạt tối đa 8.000.000 đồng',
    ],
  },
  {
    'icon': Icons.arrow_back,
    'label': 'Chạy ngược chiều',
    'data': [
      'Đi ngược chiều trên đường một chiều:\nMức phạt tối đa 2.000.000 đồng',
      'Dừng xe, đỗ xe trên phần đường xe chạy:\nMức phạt tối đa 300.000 đồng',
      'Buông cả hai tay khi điều khiển xe:\nMức phạt tối đa 8.000.000 đồng',
      'Điều khiển xe lạng lách hoặc đánh võng:\nMức phạt tối đa 8.000.000 đồng',
    ],
  },
];

final List<Map<String, dynamic>> carButtons = [
  {
    'icon': Icons.speed,
    'label': 'Quá tốc độ',
    'data': [
      'Quá tốc độ từ 5 km/h đến dưới 10 km/h:\nMức phạt tối đa 1.000.000 đồng',
      'Quá tốc độ từ 10 km/h đến 20 km/h:\nMức phạt tối đa 5.000.000 đồng',
      'Quá tốc độ từ 20 km/h đến 35 km/h:\nMức phạt tối đa 8.000.000 đồng',
      'Quá tốc độ trên 35 km/h:\nMức phạt tối đa 12.000.000 đồng',
    ],
  },
  {
    'icon': Icons.local_drink,
    'label': 'Nồng độ cồn',
    'data': [
      'Nồng độ cồn trong máu hoặc hơi thở chưa vượt quá 50 miligam:\nMức phạt tối đa 8.000.000 đồng',
      'Nồng độ cồn từ 50 đến 80 miligam:\nMức phạt tối đa 18.000.000 đồng',
      'Nồng độ cồn trên 80 miligam:\nMức phạt tối đa 40.000.000 đồng',
    ],
  },
  {
    'icon': Icons.arrow_back,
    'label': 'Chạy ngược chiều',
    'data': [
      'Dừng xe, đỗ xe không có tín hiệu báo:\nMức phạt tối đa 400.000 đồng',
      'Dừng xe, đỗ xe trên phần đường xe chạy:\nMức phạt tối đa 300.000 đồng',
      'Đi ngược chiều trên đường một chiều:\nMức phạt tối đa 5.000.000 đồng',
      'Dừng xe, đỗ xe tại nơi đường bộ giao nhau cùng mức với đường sắt:\nMức phạt tối đa 1.000.000 đồng',
      'Đi ngược chiều trên đường có biển "Cấm đi ngược chiều":\nMức phạt tối đa 5.000.000 đồng',
    ],
  },
];
