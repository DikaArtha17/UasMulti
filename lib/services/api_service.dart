import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ApiService {
  Future<List<User>> fetchUsers({int page = 1}) async {
    final response = await http.get(
      Uri.parse(
        'https://cors-anywhere.herokuapp.com/https://reqres.in/api/users?page=$page',
      ),
      headers: {"Origin": "localhost"},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List usersJson = data['data'];
      return usersJson.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data: ${response.statusCode}');
    }
  }
}
