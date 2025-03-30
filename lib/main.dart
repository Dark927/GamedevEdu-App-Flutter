import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:universal_io/io.dart';

import 'screens/main/main_screen.dart';
import 'screens/cart/cart_screen.dart';
import 'providers/cart_provider.dart';
import 'screens/auth/auth_screen.dart';
import 'firebase_options.dart';
import 'database/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize database factory for non-mobile platforms
  _initializeDatabaseFactory();

  // Initialize database
  try {
    await DatabaseHelper().database;
  } catch (e) {
    debugPrint('Database initialization error: $e');
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

void _initializeDatabaseFactory() {
  if (!kIsWeb && !Platform.isAndroid && !Platform.isIOS) {
    sqfliteFfiInit();  // Correct function name
    databaseFactory = databaseFactoryFfi;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameDev Courses',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
      routes: {
        '/auth': (context) => const AuthScreen(),
        '/cart': (context) => const CartScreen(),
        '/home' : (context) => const MainScreen(),
      },
    );
  }
}