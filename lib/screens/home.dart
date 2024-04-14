import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:elly/widgets/card.dart'; // Sesuaikan dengan nama file Anda
import 'profile.dart'; // Import file profile_screen.dart
import 'detail.dart'; // Import file detail.dart

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Galeri Otomotif',
          style: TextStyle(
            color: Colors.white, // Warna teks putih
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black, // Warna hijau tua untuk AppBar
        leading: Container(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
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
      // backgroundColor:
      //     Colors.greenAccent, // Warna hijau accent untuk latar belakang
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

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Galeri Zoologi'),
//         centerTitle: true, // Membuat judul di tengah AppBar
//         leading: Container(), // Hapus tombol kembali dari AppBar
//         actions: [
//           IconButton(
//             onPressed: () {
//               // Navigasi ke halaman ProfileScreen saat tombol profil ditekan
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const ProfileScreen()),
//               );
//             },
//             icon: const CircleAvatar(
//               // Menggunakan CircleAvatar sebagai tombol profil
//               backgroundImage: NetworkImage(
//                   'https://source.unsplash.com/random/?avatar'), // Ganti dengan URL gambar Anda dari Unsplash
//             ),
//           ),
//         ],
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream:
//             FirebaseFirestore.instance.collection('galeri_papua').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(child: Text('Something went wrong'));
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           return ListView(
//             children: snapshot.data!.docs.map((DocumentSnapshot document) {
//               final data = document.data() as Map<String, dynamic>;
//               return GestureDetector(
//                 onTap: () {
//                   // Navigasi ke halaman DetailScreen saat card ditekan
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => DetailScreen(
//                         nama: data['nama'],
//                         gambar: data['gambar'],
//                         deskripsi: data['deskripsi'],
//                       ),
//                     ),
//                   );
//                 },
//                 child: CustomCard(
//                   nama: data['nama'],
//                   gambar: data['gambar'],
//                 ),
//               );
//             }).toList(),
//           );
//         },
//       ),
//     );
//   }
// }
