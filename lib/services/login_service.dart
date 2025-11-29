// 📌 BusChat – LOGIN Service (START)

import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginService {
  final String baseUrl = "http://localhost:3000/auth";

  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      // Başarılı login
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // token, id, username döner
      }
      return null;
    } catch (e) {
      print("❌ Login Error: $e");
      return null;
    }
  }
}
