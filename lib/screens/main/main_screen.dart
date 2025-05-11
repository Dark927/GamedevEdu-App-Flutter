import 'package:flutter/material.dart';
import '../catalog_screen.dart';
import '../../widgets/custom_drawer.dart';
import '../../database/database_helper.dart';
import 'main_app_bar.dart';
import 'main_home_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final DatabaseHelper _dbHelper;
  bool _isDatabaseInitialized = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _dbHelper = DatabaseHelper();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    try {
      await _dbHelper.database;
      setState(() => _isDatabaseInitialized = true);
    } catch (e) {
      debugPrint('Database initialization error: $e');
    }
  }

  void goToHomeTab(BuildContext context) {
    if (_tabController.index != 0) {
      _tabController.animateTo(0);
    }
    if (Scaffold.maybeOf(context)?.isDrawerOpen ?? false) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _dbHelper.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isDatabaseInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: MainAppBar(),
      drawer: _buildCustomDrawer(context),
      body: _buildTabBarView(),
      bottomNavigationBar: _buildBottomTabBar(),
    );
  }

  Widget _buildCustomDrawer(BuildContext context) {
    return CustomDrawer(
      goToHomeTab: () => goToHomeTab(context),
      dbHelper: _dbHelper,
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: const [
        MainHomeTab(),
        CatalogScreen(),
      ],
    );
  }

  Widget _buildBottomTabBar() {
    return Material(
      color: Colors.white,
      elevation: 8,
      child: TabBar(
        controller: _tabController,
        labelColor: Colors.deepPurple,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.deepPurple,
        tabs: const [
          Tab(icon: Icon(Icons.home)),
          Tab(icon: Icon(Icons.list)),
        ],
      ),
    );
  }
}
