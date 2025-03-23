import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../models/course_config.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Кошик'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            tooltip: 'Очистити кошик',
            onPressed: () {
              cart.clear();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Кошик очищено')));
            },
          ),
        ],
      ),
      body:
          cart.items.isEmpty
              ? const Center(
                child: Text(
                  'Кошик порожній 🛒',
                  style: TextStyle(fontSize: 18),
                ),
              )
              : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (context, index) {
                        final course = cart.items[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.book,
                              color: Colors.deepPurple,
                            ),
                            title: Text(course.name),
                            subtitle: Text(
                              '${course.price.toStringAsFixed(2)} грн',
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => cart.remove(course),
                            ),
                            onTap: () {
                              final config = courseConfigs[course.name];
                              if (config != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => config.builder(),
                                  ),
                                );
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Загальна сума:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${cart.totalPrice.toStringAsFixed(2)} грн',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              Icons.payment,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            label: const Text(
                              'Оплатити',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            onPressed: () {
                              if (cart.items.isNotEmpty) {
                                cart.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Оплата успішна 💳'),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: Colors.deepPurple,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: Colors.deepPurple,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
