import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late Timer _timer;
  late Alignment _gradientCenter;

  @override
  void initState() {
    super.initState();
    _gradientCenter = Alignment.topLeft;
    _startRandomGradientAnimation();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startRandomGradientAnimation() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final random = Random();
      setState(() {
        _gradientCenter = Alignment(
          random.nextDouble() * 2 - 1,
          random.nextDouble() * 2 + 1,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 7),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.red.shade300,
              Colors.orange.shade300,
              Colors.yellow.shade300,
              Colors.green.shade300,
              Colors.blue.shade300,
            ],
            radius: 1.6,
            center: _gradientCenter,
            stops: const [0.0, 0.1, 0.2, 0.5, 1.0],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              color: Colors.transparent,
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Otomotif',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Text(
                      'by Elly Tombi Padang',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Lupa Kata Sandi',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: const OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        labelText: 'Email/No. Hp',
                        labelStyle: const TextStyle(color: Colors.black),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 10,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text('Kirim Link Reset Kata Sandi'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Kembali ke Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
