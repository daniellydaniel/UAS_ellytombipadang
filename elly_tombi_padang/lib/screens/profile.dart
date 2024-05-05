// import 'dart:io';
import 'dart:io';

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const ProfileScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage:
                  NetworkImage('https://source.unsplash.com/random/?male'),
            ),
            const SizedBox(height: 20),
            Text(
              'Nama: ${userData['nama']}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'NPM: ${userData['npm']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              'Jurusan: Teknik Informatika',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              'Fakultas: FIKOM',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              'Kampus: USTJ',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Konfirmasi Keluar'),
                      content: const Text('Apakah Anda yakin ingin keluar?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Tidak'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            exit(0);
                          },
                          child: const Text('Ya'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Keluar'),
            ),
          ],
        ),
      ),
    );
  }
}
