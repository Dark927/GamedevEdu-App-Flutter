import 'package:flutter/material.dart';
import '../catalog_screen.dart';
import '../../widgets/custom_drawer.dart';
import 'main_app_bar.dart';
import 'main_home_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void goToHomeTab() {
    _tabController.animateTo(0);
    Navigator.pop(context);
  }

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
      appBar: MainAppBar(),
      drawer: CustomDrawer(goToHomeTab: goToHomeTab),
      body: TabBarView(
        controller: _tabController,
        children: [MainHomeTab(), const CatalogScreen()],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        elevation: 8, // Add shadow effect
        child: TabBar(
          controller: _tabController,
          labelColor: Colors.deepPurple, // Active tab color
          unselectedLabelColor: Colors.grey, // Inactive tab color
          indicatorColor: Colors.deepPurple, // Bottom line indicator color
          tabs: const [
            Tab(icon: Icon(Icons.home), text: 'Головна'),
            Tab(icon: Icon(Icons.list), text: 'Каталог'),
          ],
        ),
      ),
    );
  }
}
