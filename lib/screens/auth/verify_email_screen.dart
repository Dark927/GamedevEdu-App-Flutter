import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../database/database_helper.dart';
import 'profile_screen.dart';

class VerifyEmailScreen extends StatefulWidget {
  final User user;
  const VerifyEmailScreen({super.key, required this.user});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _isEmailVerified = false;
  Timer? _checkTimer;
  bool _isSending = false;
  bool _accountActivated = false;
  bool _isLoading = true; // Added loading state

  @override
  void initState() {
    super.initState();
    _initializeVerification();
  }

  Future<void> _initializeVerification() async {
    // 1. First reload user to get fresh data
    await widget.user.reload();

    // 2. Check current verification status
    final currentUser = FirebaseAuth.instance.currentUser;
    _isEmailVerified = currentUser?.emailVerified ?? false;

    // 3. Start verification process if needed
    if (!_isEmailVerified) {
      await _checkPendingVerification();
      await _sendVerificationEmail();
      _startVerificationTimer();
    } else {
      await _activateAccount();
    }

    setState(() => _isLoading = false);
  }

  Future<void> _checkPendingVerification() async {
    final prefs = await SharedPreferences.getInstance();
    final pendingEmail = prefs.getString('pending_email');

    if (pendingEmail != null && pendingEmail != widget.user.email) {
      await prefs.remove('pending_email');
      await prefs.remove('pending_password');
    }
  }

  void _startVerificationTimer() {
    _checkTimer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) async {
        await _checkEmailVerified();
      },
    );
  }

  @override
  void dispose() {
    _checkTimer?.cancel();
    super.dispose();
  }

  Future<void> _sendVerificationEmail() async {
    try {
      setState(() => _isSending = true);

      final prefs = await SharedPreferences.getInstance();
      final lastSent = prefs.getInt('last_verification_sent') ?? 0;
      final now = DateTime.now().millisecondsSinceEpoch;

      if (now - lastSent < 60000) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content:
                    Text('Зачекайте 1 хвилину перед повторною відправкою')),
          );
        }
        return;
      }

      await widget.user.sendEmailVerification();
      await prefs.setInt('last_verification_sent', now);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Лист для підтвердження надіслано!')),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(e.code == 'too-many-requests'
                  ? 'Забагато запитів. Спробуйте пізніше'
                  : 'Помилка надсилання листа')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Невідома помилка: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  Future<void> _checkEmailVerified() async {
    try {
      // 1. Reload user data from Firebase
      await widget.user.reload();

      // 2. Get fresh user instance
      final currentUser = FirebaseAuth.instance.currentUser;

      // 3. Check verification status
      if (currentUser != null &&
          currentUser.emailVerified &&
          !_accountActivated) {
        await _activateAccount();
      }
    } catch (e) {
      debugPrint('Error checking email verification: $e');
    }
  }

  Future<void> _activateAccount() async {
    try {
      final dbHelper = DatabaseHelper();

      // 1. Update database
      await dbHelper.markUserAsVerified(widget.user.uid);

      // 2. Update Firebase user
      await widget.user.updateDisplayName('verified');

      // 3. Update app state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', widget.user.uid);
      await prefs.setBool('showVerificationSuccess', true);
      await prefs.remove('pending_email');
      await prefs.remove('pending_password');

      // 4. Stop verification timer
      _checkTimer?.cancel();

      // 5. Update UI state
      if (mounted) {
        setState(() {
          _isEmailVerified = true;
          _accountActivated = true;
        });

        // 6. Navigate to home
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Помилка активації: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Підтвердження email'),
        backgroundColor: Colors.deepPurple,
        actions: [
          if (!_isEmailVerified)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                if (mounted) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                }
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isEmailVerified
                  ? '✅ Ваш email підтверджено! Акаунт активовано.'
                  : '📨 Ми надіслали листа для підтвердження на ${widget.user.email}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            if (!_isEmailVerified) ...[
              const Text(
                'Будь ласка, перевірте вашу поштову скриньку та натисніть на посилання для підтвердження.',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'Якщо лист не надійшов, перевірте папку "Спам" або спробуйте відправити ще раз.',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _isSending ? null : _sendVerificationEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  icon: _isSending
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.email, size: 20),
                  label: Text(
                    _isSending ? 'Відправка...' : 'Надіслати лист ще раз',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    if (mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    }
                  },
                  child: const Text(
                    'Скасувати реєстрацію',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ],
            if (_isEmailVerified) ...[
              const Icon(Icons.check_circle, size: 80, color: Colors.green),
              const SizedBox(height: 20),
              const Text(
                'Вітаємо! Ваш акаунт успішно підтверджено.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProfileScreen(),
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: const Text(
                    'Перейти до додатка',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
