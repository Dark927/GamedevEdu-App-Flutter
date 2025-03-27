import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/courses/course.dart';
import '../../providers/cart_provider.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final cartCount = cart.items.length;

    return AppBar(
      title: const Text('GameDev Courses'),
      actions: [
        DragTarget<Course>(
          onAcceptWithDetails: (details) {
            final course = details.data;
            Provider.of<CartProvider>(context, listen: false).add(course);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${course.name} додано до кошика'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          builder: (context, candidateData, rejectedData) {
            return Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  tooltip: 'Кошик',
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
                if (cartCount > 0)
                  Positioned(
                    right: 20,
                    top: 15,
                    child: IgnorePointer(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 15,
                          minHeight: 15,
                        ),
                        child: Text(
                          '$cartCount',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
