import 'package:flutter/material.dart';

import '../../elements/laws_button_list.dart';

class LawsScreen extends StatefulWidget {
  @override
  _LawsScreenState createState() => _LawsScreenState();
}

class _LawsScreenState extends State<LawsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tra cứu luật giao thông'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Xe máy'),
            Tab(text: 'Xe Ô tô'),
            Tab(text: 'Khác'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LawsButtonList(),
          Center(child: Text('Content for Tab 2')),
          Center(child: Text('Content for Tab 3')),
        ],
      ),
    );
  }
}
