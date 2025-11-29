import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "Yükleniyor...";

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? "Kullanıcı adı bulunamadı";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SafeArea(
        child: Stack(
          children: [
            // ✦ Ayarlar – Sol Üst
            Positioned(
              left: 15,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white, size: 26),
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ayar menüsü yakında!")),
                ),
              ),
            ),

            // ✦ Çıkış – Sağ Üst
            Positioned(
              right: 15,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.logout, color: Colors.white, size: 26),
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.clear(); // çıkış yapınca kullanıcı silinir
                  Navigator.pushReplacementNamed(context, "/auth");
                },
              ),
            ),

            // 🔥 PROFIL UI
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      "https://i.imgur.com/vJg3z1P.jpeg",
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// 🔥 ARTIK BACKEND'DEN GELEN KULLANICI ADI BURADA
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 6),
                  const Text(
                    "Profiline dokunarak düzenle",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),

                  const SizedBox(height: 22),

                  // 📊 İstatistik Alanı
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      statItem(Icons.group, "6", "takipçi"),
                      const SizedBox(width: 26),
                      statItem(Icons.local_fire_department, "0", "etkileşim"),
                      const SizedBox(width: 26),
                      statItem(Icons.chat_bubble_outline, "0", "konuşma"),
                    ],
                  ),

                  const SizedBox(height: 35),

                  profileButton(
                    label: "Profilini Paylaş",
                    color: Colors.blueAccent,
                  ),
                  const SizedBox(height: 15),

                  profileButton(
                    label: "Profilini Düzenle",
                    isOutline: true,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const EditProfilePage(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- İstatistik Widgetı ----
  Widget statItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 26),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 15)),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }

  // ---- Profil Butonları ----
  Widget profileButton({
    required String label,
    bool isOutline = false,
    Function? onTap,
    Color color = Colors.blueAccent,
  }) {
    return SizedBox(
      width: 240,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutline ? Colors.transparent : color,
          side: BorderSide(color: Colors.blueAccent, width: isOutline ? 2 : 0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: () => onTap?.call(),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: isOutline ? Colors.blueAccent : Colors.white,
          ),
        ),
      ),
    );
  }
}
