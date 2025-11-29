import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String username = "kullanici_adi";
  String bio = "Kendimi burada biraz anlatabilirim...";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Profili Düzenle",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            // 🔥 Profil Fotoğrafı
            GestureDetector(
              onTap: () {
                /// Buraya daha sonra fotoğraf seçme gelecek
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Fotoğraf yükleme yakında aktif!"),
                  ),
                );
              },
              child: const CircleAvatar(
                radius: 55,
                backgroundColor: Colors.white30,
                child: Icon(Icons.camera_alt, color: Colors.white, size: 32),
              ),
            ),

            const SizedBox(height: 30),

            // 🔤 Kullanıcı adı alanı
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Kullanıcı adı",
                labelStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              onChanged: (v) => username = v,
            ),

            const SizedBox(height: 25),

            // ✍ Biyografi alanı
            TextField(
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Biyografi",
                labelStyle: TextStyle(color: Colors.white54),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white38),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
              ),
              onChanged: (v) => bio = v,
            ),

            const Spacer(),

            // 💾 Kaydet Butonu
            SizedBox(
              height: 52,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context); // Şimdilik sadece geri dönüyor
                },
                child: const Text("Kaydet", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
