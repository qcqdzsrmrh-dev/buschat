import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../main.dart'; // MainNavigation'a geçmek için

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool showLogin = false; // false -> signup ilk gelsin

  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPass = TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFAAD7FF), Color(0xFF70B6FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // LOGO
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(.25),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 10),
                      ],
                    ),
                    child: const Icon(
                      Icons.theater_comedy_rounded,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "BusChat",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    showLogin ? "Giriş Yap" : "Kayıt Ol",
                    style: const TextStyle(fontSize: 18, color: Colors.white70),
                  ),
                  const SizedBox(height: 25),

                  // FORM
                  Container(
                    width: 500,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.30),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: Colors.white60),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 15),
                      ],
                    ),
                    child: Column(
                      children: [
                        _field("Email", email),
                        if (!showLogin) ...[
                          const SizedBox(height: 10),
                          _field("Kullanıcı adı", username),
                        ],
                        const SizedBox(height: 10),
                        _field("Şifre", password, pass: true),
                        if (!showLogin) ...[
                          const SizedBox(height: 10),
                          _field("Şifre tekrar", confirmPass, pass: true),
                        ],
                        const SizedBox(height: 12),
                        if (errorMessage != null)
                          Text(
                            errorMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        const SizedBox(height: 6),
                        _button(
                          showLogin ? "Giriş Yap" : "Kayıt Ol",
                          _handleAuth,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showLogin = !showLogin;
                        errorMessage = null;
                      });
                    },
                    child: Text(
                      showLogin
                          ? "Hesabın yok mu? Kayıt ol →"
                          : "Zaten hesabın var mı? Giriş yap →",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 LOGIN & SIGNUP ÇALIŞAN YER
  void _handleAuth() async {
    final auth = AuthService();

    if (!showLogin && password.text != confirmPass.text) {
      setState(() => errorMessage = "Şifreler uyuşmuyor ❗");
      return;
    }

    Map? result;

    if (showLogin) {
      // LOGIN
      result = await auth.login(email.text.trim(), password.text.trim());
    } else {
      // SIGNUP
      result = await auth.signup(
        email.text.trim(),
        username.text.trim(),
        password.text.trim(),
      );
    }

    if (result != null) {
      if (!showLogin) {
        // ✅ Signup’tan sonra: OTOMATİK GİRİŞ YOK
        // Sadece login moduna geçiyoruz.
        setState(() {
          showLogin = true;
          errorMessage = "Kayıt başarılı ✔ Şimdi giriş yapabilirsiniz.";
        });
      } else {
        // ✅ LOGIN BAŞARILI → UYGULAMAYA GİR
        final uname = result["username"] ?? "kullanıcı";
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MainNavigation(username: uname)),
        );
      }
    } else {
      setState(() => errorMessage = "Bilgiler hatalı ❗");
    }
  }
}

// UI helpers
Widget _field(String text, TextEditingController c, {bool pass = false}) {
  return TextField(
    controller: c,
    obscureText: pass,
    decoration: InputDecoration(
      hintText: text,
      filled: true,
      fillColor: Colors.white.withOpacity(.55),
      hintStyle: const TextStyle(color: Colors.black54),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white),
      ),
    ),
  );
}

Widget _button(String text, VoidCallback action) {
  return SizedBox(
    width: 220,
    height: 54,
    child: ElevatedButton(
      onPressed: action,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
