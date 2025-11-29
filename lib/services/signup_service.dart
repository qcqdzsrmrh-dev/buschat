// 📌 BusChat – SIGN UP Service (START)

import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupService {
  final String baseUrl = "http://localhost:3000/auth"; // Backend URL

  Future<bool> registerUser({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "username": username,
          "password": password,
        }),
      );

      // 200 başarılı
      return response.statusCode == 200;
    } catch (e) {
      print("❌ SignUp Error: $e");
      return false;
    }
  }
}
