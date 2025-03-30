import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedCredentials();
  }

  Future<void> _loadRememberedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _rememberMe = prefs.getBool('rememberMe') ?? false;
      if (_rememberMe) {
        _emailController.text = prefs.getString('savedEmail') ?? '';
        _passwordController.text = prefs.getString('savedPassword') ?? '';
      }
    });
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('savedEmail', _emailController.text.trim());
      await prefs.setString('savedPassword', _passwordController.text.trim());
      await prefs.setBool('rememberMe', true);
    } else {
      await prefs.remove('savedEmail');
      await prefs.remove('savedPassword');
      await prefs.setBool('rememberMe', false);
    }
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Будь ласка, введіть email та пароль')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Save credentials if "remember me" is checked
      await _saveCredentials();

      // Sign in with Firebase
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (!context.mounted) return;

      // Check if email is verified
      if (userCredential.user?.emailVerified ?? false) {
        // Navigate to home screen or wherever needed
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        // If email not verified, send verification email
        await userCredential.user?.sendEmailVerification();
        if (!context.mounted) return;
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Будь ласка, підтвердіть ваш email. Ми відправили листа з підтвердженням.')),
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Помилка авторизації';
      
      if (e.code == 'user-not-found') {
        message = 'Користувача з таким email не знайдено';
      } else if (e.code == 'wrong-password') {
        message = 'Невірний пароль';
      } else if (e.code == 'invalid-email') {
        message = 'Невірний формат email';
      } else if (e.code == 'user-disabled') {
        message = 'Цей акаунт було вимкнено';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Сталася помилка: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text('Запамʼятати мене на 30 днів'),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton.icon(
                  onPressed: _handleLogin,
                  icon: const Icon(Icons.login, color: Colors.white),
                  label: const Text(
                    'Увійти',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}