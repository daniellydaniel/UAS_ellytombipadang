import 'package:elly/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile.dart'; // Import ProfileScreen
import 'detail.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  final String userId;

  const HomeScreen({
    Key? key,
    required this.userData,
    required this.userId,
  }) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseFirestore.instance.collection('otomotif').snapshots();
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextField(
        onChanged: _filterData,
        decoration: InputDecoration(
          hintText: 'Cari...',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
        ),
      ),
    );
  }

  Widget _buildListItem(DocumentSnapshot document) {
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
  }

  void _filterData(String query) {
    setState(() {
      _stream = FirebaseFirestore.instance
          .collection('otomotif')
          .where('nama', isGreaterThanOrEqualTo: query)
          .where('nama', isLessThan: '${query}z')
          .snapshots();
    });
  }

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
                      'nama':
                          widget.userData['name'], // Tambahkan nama pengguna
                      'npm': widget.userData['npm'], // Tambahkan NPM pengguna
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: _buildSearchBar(),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return _buildListItem(document);
            }).toList(),
          );
        },
      ),
    );
  }
}
