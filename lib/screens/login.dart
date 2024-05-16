import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart'; // Import HomeScreen
import 'forgot_password.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _npmController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late Timer _timer;
  late Alignment _gradientCenter;
  late String _userId; // Variabel untuk menyimpan ID dokumen pengguna

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
                    'Silahkan Masuk',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _npmController,
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
                      labelText: 'NPM',
                      labelStyle: const TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    style: const TextStyle(color: Colors.black),
                    obscureText: true,
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
                      labelText: 'Kata Sandi',
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
                      _login().then((success) {
                        if (success) {
                          // Fetch user data and navigate to HomeScreen
                          _fetchUserDataAndNavigate(_npmController.text.trim());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login gagal!'),
                            ),
                          );
                        }
                      });
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
                        child: Text('Masuk'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Daftar!'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ForgotPasswordPage()),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Lupa Kata Sandi?'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _login() async {
    try {
      // Get NPM and password from text fields
      String npm = _npmController.text.trim();
      String password = _passwordController.text.trim();

      // Query Firestore to check if the user exists
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('user').doc(npm).get();

      // If user exists and password matches, save the userId and return true
      if (snapshot.exists && snapshot.data()!['password'] == password) {
        _userId = npm;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }

  void _fetchUserDataAndNavigate(String npm) {
    FirebaseFirestore.instance
        .collection('user')
        .doc(npm)
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                HomeScreen(userData: userData, userId: _userId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data pengguna tidak ditemukan!'),
          ),
        );
      }
    }).catchError((error) {
      print('Error fetching user data: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terjadi kesalahan saat mengambil data pengguna!'),
        ),
      );
    });
  }
}
