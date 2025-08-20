import 'dart:convert';

import 'package:http/http.dart' as http;

class UserApi {
  static const host = 'https://jsonplaceholder.typicode.com';
  static const headers = {'Content-Type': 'application/json'};

  Future<List<UserDto>> getUsers() async {
    final response = await http.get(
      Uri.parse('$host/users'),
      headers: headers,
    );
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => UserDto.fromJson(json)).toList();
  }

  Future<UserDto> getUser(int id) async {
    final response = await http.get(
      Uri.parse('$host/users/$id'),
      headers: headers,
    );
    return UserDto.fromJson(jsonDecode(response.body));
  }
}

class UserDto {
  final int id;
  final String name;
  final String email;

  UserDto({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }
}
