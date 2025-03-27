import 'package:flutter/material.dart';
import 'register_form.dart';
import 'login_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _loginEmailController = TextEditingController();
  final _loginPasswordController = TextEditingController();
  final _registerEmailController = TextEditingController();
  final _registerPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Аутентифікація'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white, // колір активної вкладки
          unselectedLabelColor: Colors.white70, // колір неактивних вкладок
          tabs: const [Tab(text: 'Вхід'), Tab(text: 'Реєстрація')],
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: TabBarView(
        controller: _tabController,
        children: [LoginForm(), RegisterForm()],
      ),
    );
  }
}
