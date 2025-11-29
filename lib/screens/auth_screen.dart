import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import '../main.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true; // true = Giriş Yap, false = Kayıt Ol

  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  String? errorText; // hata veya bilgi mesajı

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(
                Icons.theater_comedy_rounded,
                size: 80,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 12),
              const Text(
                "BusChat",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Text(
                isLogin ? "Giriş Yap" : "Kayıt Ol",
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 24),

              // E-posta
              _field("E-posta", email),

              // Kayıt modundaysak kullanıcı adı da göster
              if (!isLogin) ...[
                const SizedBox(height: 10),
                _field("Kullanıcı adı (sadece kayıt)", username),
              ],

              const SizedBox(height: 10),
              _field("Şifre", password, obs: true),

              if (!isLogin) ...[
                const SizedBox(height: 10),
                _field("Şifre tekrar", confirmPassword, obs: true),
              ],

              const SizedBox(height: 10),

              if (errorText != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    errorText!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: errorText!.startsWith("✅")
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                ),

              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: _handleAuth,
                child: Text(isLogin ? "Giriş Yap" : "Kayıt Ol"),
              ),

              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  setState(() {
                    isLogin = !isLogin;
                    errorText = null;
                    password.clear();
                    confirmPassword.clear();
                  });
                },
                child: Text(
                  isLogin
                      ? "Hesabın yok mu? Kayıt ol →"
                      : "Zaten hesabın var mı? Giriş yap →",
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 LOGIN & SIGNUP İŞLEMLERİ (SADELEŞTİRİLMİŞ VE GÜVENLİ)
  void _handleAuth() async {
    final auth = AuthService();
    Map? res;

    if (!isLogin) {
      // KAYIT MODU
      if (email.text.trim().isEmpty ||
          username.text.trim().isEmpty ||
          password.text.trim().isEmpty ||
          confirmPassword.text.trim().isEmpty) {
        setState(() => errorText = "Lütfen tüm alanları doldur.");
        return;
      }

      if (password.text.trim() != confirmPassword.text.trim()) {
        setState(() => errorText = "Şifreler uyuşmuyor.");
        return;
      }

      res = await auth.signup(
        email.text.trim(),
        username.text.trim(),
        password.text.trim(),
      );

      if (res == null || res["success"] != true) {
        setState(
          () => errorText =
              "Kayıt başarısız. Email veya kullanıcı adı kullanılıyor olabilir.",
        );
        return;
      }

      // Kayıt başarılı → login moduna dön, mail kalsın, info mesajı göster
      setState(() {
        isLogin = true;
        errorText = "✅ Kayıt başarılı! Şimdi email ve şifrenle giriş yap.";
        password.clear();
        confirmPassword.clear();
      });

      return;
    } else {
      // GİRİŞ MODU (SADECE E-POSTA + ŞİFRE)
      if (email.text.trim().isEmpty || password.text.trim().isEmpty) {
        setState(() => errorText = "Lütfen email ve şifre gir.");
        return;
      }

      res = await auth.login(email.text.trim(), password.text.trim());

      if (res == null || res["success"] != true) {
        setState(() => errorText = "Giriş başarısız. Email veya şifre hatalı.");
        return;
      }

      final userName = (res["username"] ?? email.text.trim()).toString();

      // Kullanıcı adını kaydet
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", userName);

      // Profil + app içi kısımlara geç
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainNavigation(username: userName)),
      );
    }
  }
}

// ------------------------------------------------------
// INPUT TASARIMI
// ------------------------------------------------------
Widget _field(String hint, TextEditingController c, {bool obs = false}) {
  return SizedBox(
    width: 300,
    child: TextField(
      controller: c,
      obscureText: obs,
      enableSuggestions: !obs,
      autocorrect: !obs,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}
