// Final version of your UserListPage adapted from the provided code

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import 'profile_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  Future<void> _refreshData() async {
    setState(() {
      futureUsers = fetchUsers();
    });
  }

  Future<List<User>> fetchUsers() async {
    final response = await http.get(
      Uri.parse('https://reqres.in/api/users?page=1'),
      headers: {"x-api-key": "reqres-free-v1"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List usersJson = data['data'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception("Gagal mengambil data pengguna: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar User"),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<User>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada data user.'));
          } else {
            final users = snapshot.data!;
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.avatar),
                    ),
                    title: Text('${user.firstName} ${user.lastName}'),
                    subtitle: Text(user.email),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Email: ${user.email}')),
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
