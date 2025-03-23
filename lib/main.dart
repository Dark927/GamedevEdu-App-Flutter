import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main/main_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'providers/cart_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CartProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameDev Courses',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const MainScreen(),
      routes: {'/cart': (context) => const CartScreen()},
    );
  }
}
