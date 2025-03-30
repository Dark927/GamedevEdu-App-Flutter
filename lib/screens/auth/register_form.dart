import 'package:flutter/material.dart';
import 'verify_email_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../database/database_helper.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    // Validate inputs
    if (email.isEmpty || password.isEmpty || firstName.isEmpty || lastName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Будь ласка, заповніть всі поля')),
      );
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Будь ласка, введіть коректний email')),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пароль повинен містити щонайменше 6 символів')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Create user in Firebase
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      
      // 2. Send verification email
      await userCredential.user?.sendEmailVerification();
      
      // 3. Update user profile with name
      await userCredential.user?.updateDisplayName('$firstName $lastName');
      
      // 4. Save to local database
      final dbHelper = DatabaseHelper();
      await dbHelper.createUser(
        userCredential.user!.uid, 
        email,
        firstName: firstName,
        lastName: lastName,
      );
      
      // 5. Clear any existing user products
      await dbHelper.clearUserProducts(userCredential.user!.uid);

      // 6. Save registration state
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('pending_email', email);
      await prefs.setString('pending_password', password);
      await prefs.setString('userId', userCredential.user!.uid);
      await prefs.setString('user_name', '$firstName $lastName');

      if (!context.mounted) return;

      // 7. Navigate to verification screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => VerifyEmailScreen(user: userCredential.user!),
        ),
      );

    } on FirebaseAuthException catch (e) {
      String message = 'Помилка реєстрації';
      switch (e.code) {
        case 'email-already-in-use':
          message = 'Цей email вже використовується';
          break;
        case 'invalid-email':
          message = 'Невірний формат email';
          break;
        case 'weak-password':
          message = 'Пароль надто простий';
          break;
        case 'operation-not-allowed':
          message = 'Реєстрація вимкнена';
          break;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Помилка: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 100),
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Реєстрація',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _firstNameController,
                        decoration: const InputDecoration(
                          labelText: 'Імʼя',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          labelText: 'Прізвище',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Пароль',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                  obscureText: !_isPasswordVisible,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: _isLoading ? null : _handleRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'Зареєструватися',
                      style: TextStyle(fontSize: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}