import 'package:elly/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile.dart'; // Import ProfileScreen
import 'detail.dart';

class HomeScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  final String userId;

  const HomeScreen({
    Key? key,
    required this.userData,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Galeri Otomotif',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(
                    userData: {
                      'nama': userData['name'], // Tambahkan nama pengguna
                      'npm': userData['npm'], // Tambahkan NPM pengguna
                    },
                  ),
                ),
              );
            },
            icon: const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://source.unsplash.com/random/?female',
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('otomotif').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              final data = document.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        nama: data['nama'],
                        gambar: data['gambar'],
                        deskripsi: data['deskripsi'],
                      ),
                    ),
                  );
                },
                child: CustomCard(
                  nama: data['nama'],
                  gambar: data['gambar'],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
