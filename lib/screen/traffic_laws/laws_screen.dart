import 'package:flutter/material.dart';

import '../../data/traffic_violation_laws.dart';
import '../../elements/laws_button_list.dart';

/// Màn hình luật giao thông

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
    _tabController = TabController(length: 2, vsync: this);
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
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          LawsButtonList(buttons: motorcycleButtons, vehicleType: 'Xe máy'),
          LawsButtonList(buttons: carButtons, vehicleType: 'Xe ô tô'),
        ],
      ),
    );
  }
}
