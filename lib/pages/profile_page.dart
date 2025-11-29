import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // Üst Köşe Butonları *********************************
      body: SafeArea(
        child: Stack(
          children: [
            // ✦ Ayarlar (Sol üst)
            Positioned(
              left: 15,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.white, size: 26),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ayar menüsü yakında!")),
                  );
                },
              ),
            ),

            // ✦ Çıkış (Sağ üst)
            Positioned(
              right: 15,
              top: 10,
              child: IconButton(
                icon: const Icon(Icons.logout, color: Colors.white, size: 26),
                onPressed: () {
                  Navigator.pop(context); // şimdilik welcome’a dönüş gibi
                },
              ),
            ),

            // İÇERİK ****************************************************
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),

                  // 🔥 Profil Foto
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                      "https://i.imgur.com/vJg3z1P.jpeg", // İstediğinde değiştir
                    ),
                  ),

                  const SizedBox(height: 14),

                  // Kullanıcı Adı
                  const Text(
                    "kullanici_adi",
                    style: TextStyle(
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

                  // 📊 Mini istatistikler - daha yakın ve merkezli
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

                  // ⭐ BUTONLAR
                  profileButton(
                    label: "Profilini Paylaş",
                    color: Colors.blueAccent,
                    onTap: () {},
                  ),

                  const SizedBox(height: 15),

                  profileButton(
                    label: "Profilini Düzenle",
                    isOutline: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfilePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- İstatistik Kartı ----
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

  // ---- Profil Sayfası Butonları ----
  Widget profileButton({
    required String label,
    bool isOutline = false,
    required Function onTap,
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
        onPressed: () => onTap(),
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
