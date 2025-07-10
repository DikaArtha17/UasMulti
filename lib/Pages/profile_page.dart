import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Developer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Foto profil
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('images/dikaa.jpg'),
              ),
              const SizedBox(height: 16),

              // Informasi developer
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text('Nama: Dika'),
                  Text('Email: dikaartha@example.com'),
                  Text('No HP: 082370856701'),
                  Text('Prodi: Rekayasa Perangkat Lunak'),
                  Text('Jurusan: Teknik Informatika'),
                  Text('Perguruan Tinggi: Politeknik Negeri Bengkalis'),
                ],
              ),

              const SizedBox(height: 32),

              // Logo kampus
              Image.asset('images/polbeng.png', height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
