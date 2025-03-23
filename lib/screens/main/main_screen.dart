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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: MainAppBar(),
        drawer: CustomDrawer(goToHomeTab: goToHomeTab),
        body: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(icon: Icon(Icons.home), text: 'Головна'),
                Tab(icon: Icon(Icons.list), text: 'Каталог'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [MainHomeTab(), const CatalogScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
