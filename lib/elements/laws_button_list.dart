import 'package:flutter/material.dart';

class LawsButtonList extends StatelessWidget {
  final List<Map<String, dynamic>> buttons = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.settings, 'label': 'Settings'},
    {'icon': Icons.favorite, 'label': 'Favorites'},
    {'icon': Icons.contact_mail, 'label': 'Contacts'},
    {'icon': Icons.camera, 'label': 'Camera'},
    {'icon': Icons.alarm, 'label': 'Alarm'},
    {'icon': Icons.mail, 'label': 'Mail'},
    {'icon': Icons.map, 'label': 'Map'},
    {'icon': Icons.music_note, 'label': 'Music'},
    {'icon': Icons.games, 'label': 'Games'},
    {'icon': Icons.shop, 'label': 'Shop'},
    {'icon': Icons.info, 'label': 'Info'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1, // Tỷ lệ hình chữ nhật
        ),
        itemCount: buttons.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Xử lý sự kiện nhấn nút
              print('${buttons[index]['label']} pressed');
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        buttons[index]['icon'],
                        color: Colors.white,
                        size: 35,
                      ),
                      SizedBox(height: 0),
                    ],
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
      ),
    );
  }
}
