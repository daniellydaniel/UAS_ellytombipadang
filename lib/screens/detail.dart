import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String nama;
  final String gambar;
  final String deskripsi;

  const DetailScreen({
    Key? key,
    required this.nama,
    required this.gambar,
    required this.deskripsi,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail',
          style: TextStyle(
            color: Colors.white, // Warna teks putih
          ),
        ),
        centerTitle: true, // Mengatur teks di tengah
        backgroundColor: Colors.black, // Atur warna latar belakang
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header untuk gambar
            Container(
              width: double.infinity,
              height: 200, // Sesuaikan dengan kebutuhan Anda
              decoration: BoxDecoration(
                // Periksa keberadaan gambar sebelum digunakan
                image: gambar.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(gambar),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              // Tampilkan placeholder jika gambar tidak tersedia
              child: gambar.isNotEmpty
                  ? null
                  : const Center(child: Text('Image not available')),
            ),
            const SizedBox(height: 16),
            // Title
            Text(
              nama,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Deskripsi penjelasan
            Text(
              deskripsi,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
