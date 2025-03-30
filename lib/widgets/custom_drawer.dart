import 'package:flutter/material.dart';
import '../database/database_helper.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback goToHomeTab;
  final DatabaseHelper dbHelper;

  const CustomDrawer({
    super.key, 
    required this.goToHomeTab,
    required this.dbHelper,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildDrawerHeader(),
          _buildHomeTile(context),
          _buildProfileTile(context),
          _buildCartTile(context),
          _buildAppUsersSection(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return const DrawerHeader(
      decoration: BoxDecoration(color: Colors.deepPurple),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.gamepad, size: 50, color: Colors.white),
          SizedBox(height: 10),
          Text(
            'GameDev Hub',
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Game development learning',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.home, color: Colors.deepPurple),
      title: const Text('Home'),
      onTap: () {
        Navigator.pop(context); // Close the drawer
        Navigator.pushNamed(context, '/home'); // Navigate to home route
      },
    );
  }

  Widget _buildProfileTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person, color: Colors.deepPurple),
      title: const Text('Profile'),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/auth');
      },
    );
  }

  Widget _buildCartTile(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.shopping_cart, color: Colors.deepPurple),
      title: const Text('Cart'),
      onTap: () {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/cart');
      },
    );
  }

  Widget _buildAppUsersSection(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: dbHelper.getAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingUsersTile();
        }
        
        if (snapshot.hasError) {
          return _buildErrorTile(context, snapshot.error.toString());
        }

        final users = snapshot.data ?? [];
        return _buildUsersExpansionTile(users);
      },
    );
  }

  Widget _buildLoadingUsersTile() {
    return const ListTile(
      leading: Icon(Icons.people, color: Colors.deepPurple),
      title: Text('Loading users...'),
    );
  }

  Widget _buildErrorTile(BuildContext context, String error) {
    return ListTile(
      leading: const Icon(Icons.error, color: Colors.red),
      title: const Text('Error loading users'),
      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      ),
    );
  }

  Widget _buildUsersExpansionTile(List<Map<String, dynamic>> users) {
    return ExpansionTile(
      leading: const Icon(Icons.people, color: Colors.deepPurple),
      title: const Text('App Users'),
      children: [
        if (users.isEmpty)
          _buildNoUsersFound()
        else
          ...users.map(_buildUserTile).toList(),
      ],
    );
  }

  Widget _buildNoUsersFound() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text('No users found'),
    );
  }

  Widget _buildUserTile(Map<String, dynamic> user) {
    return ListTile(
      title: Text(user['email'] ?? 'Unknown'),
      subtitle: Text(
        'Verified: ${user['verified'] == 1 ? 'Yes' : 'No'}',
        style: TextStyle(
          color: user['verified'] == 1 ? Colors.green : Colors.orange,
        ),
      ),
    );
  }
}