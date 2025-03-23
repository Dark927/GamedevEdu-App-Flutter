import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final VoidCallback goToHomeTab;

  const CustomDrawer({super.key, required this.goToHomeTab});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
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
                  'Навчання геймдеву',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.deepPurple),
            title: const Text('Головна'),
            onTap: goToHomeTab,
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.deepPurple),
            title: const Text('Профіль'),
            onTap: () {
              Navigator.pop(context);
              // Можна додати перехід на профіль пізніше
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.deepPurple),
            title: const Text('Кошик'),
            onTap: () {
              Navigator.pop(context); // Закриває Drawer
              Navigator.pushNamed(context, '/cart'); // Відкриває кошик
            },
          ),
        ],
      ),
    );
  }
}
