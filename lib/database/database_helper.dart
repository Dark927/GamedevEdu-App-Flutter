import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

class DatabaseHelper {
  // Singleton pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'user_products.db');
    debugPrint('Database Path: $path');
    return await openDatabase(
      path,
      version: 2, // Incremented version number for schema change
      onCreate: _onCreate,
      onConfigure: _onConfigure,
      onUpgrade: _onUpgrade, // Added onUpgrade callback
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id TEXT PRIMARY KEY,
        email TEXT UNIQUE NOT NULL,
        first_name TEXT,
        last_name TEXT,
        verified INTEGER DEFAULT 0,
        created_at TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT NOT NULL,
        name TEXT NOT NULL,
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (userId) REFERENCES users (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('CREATE INDEX idx_products_userId ON products(userId)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
        ALTER TABLE users 
        ADD COLUMN first_name TEXT
      ''');
      await db.execute('''
        ALTER TABLE users 
        ADD COLUMN last_name TEXT
      ''');
      await db.execute('''
        ALTER TABLE users 
        ADD COLUMN created_at TEXT
      ''');
    }
  }

  Future<void> createUser(
    String id,
    String email, {
    String? firstName,
    String? lastName,
    bool isVerified = false,
    DateTime? createdAt,
  }) async {
    final db = await database;

    try {
      final userData = {
        'id': id,
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'verified': isVerified ? 1 : 0,
        'created_at':
            createdAt?.toIso8601String() ?? DateTime.now().toIso8601String(),
      };

      _debugPrint('Creating user with data: $userData');

      final result = await db.insert(
        'users',
        userData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      _debugPrint('User created successfully with rowId: $result');
    } on DatabaseException catch (e) {
      _debugPrint('Error creating user: ${e.toString()}');
      rethrow;
    } catch (e) {
      _debugPrint('Unexpected error creating user: ${e.toString()}');
      rethrow;
    }
  }

  void _debugPrint(String message) {
    if (kDebugMode) {
      debugPrint('[DatabaseHelper] $message');
    }
  }

  Future<void> markUserAsVerified(String userId) async {
    final db = await database;
    await db.update(
      'users',
      {'verified': 1},
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<bool> isUserVerified(String userId) async {
    final db = await database;
    final result = await db.query(
      'users',
      columns: ['verified'],
      where: 'id = ?',
      whereArgs: [userId],
    );
    return result.isNotEmpty && result.first['verified'] == 1;
  }

  // Продукти
  Future<int> addProduct(String userId, String productName) async {
    final db = await database;
    return await db.insert('products', {'userId': userId, 'name': productName});
  }

  Future<List<Map<String, dynamic>>> getUserProducts(String userId) async {
    final db = await database;
    return await db.query(
      'products',
      where: 'userId = ?',
      whereArgs: [userId],
      orderBy: 'createdAt DESC',
    );
  }

  Future<int> deleteProduct(int productId) async {
    final db = await database;
    return await db.delete('products', where: 'id = ?', whereArgs: [productId]);
  }

  Future<void> clearUserProducts(String userId) async {
    final db = await database;
    await db.delete('products', where: 'userId = ?', whereArgs: [userId]);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
    _database = null;
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final db = await database;
    return await db.query('users'); // Returns all users from users table
  }

  Future<Map<String, dynamic>?> getUser(String userId) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }
}
