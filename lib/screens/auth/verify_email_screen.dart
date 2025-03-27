import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({super.key, required this.email});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final _codeController = TextEditingController();
  final String _fakeCode = '123456'; // Заглушка (реальний код буде з сервера)

  void _verifyCode() {
    if (_codeController.text.trim() == _fakeCode) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Верифікація пройдена успішно!')),
      );
      // TODO: Перевести на головну або в профіль
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Неправильний код')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Підтвердження email'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ми надіслали код на ${widget.email}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Введіть код підтвердження',
                prefixIcon: Icon(Icons.verified_user),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _verifyCode,
                child: const Text('Підтвердити'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
