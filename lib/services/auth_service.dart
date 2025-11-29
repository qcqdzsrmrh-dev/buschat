import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://localhost:3000/auth";

  // 🔥 SIGNUP
  Future<Map?> signup(String email, String username, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "username": username,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // 🔥 Map döner
    }
    return null;
  }

  // 🔥 LOGIN — email veya username ile giriş
  Future<Map?> login(String emailOrUsername, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": emailOrUsername, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // 🔥 Map döner
    }
    return null;
  }
}
