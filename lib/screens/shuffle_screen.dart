import 'package:flutter/material.dart';
import 'chat_screen.dart';

class ShuffleScreen extends StatelessWidget {
  final bool isPlusUser;
  const ShuffleScreen({super.key, this.isPlusUser = false});

  @override
  Widget build(BuildContext context) {
    // 👇 Test kullanıcı listesi (sonradan server'dan çekeceğiz)
    List<Map<String, dynamic>> users = [
      {
        "name": "Merve",
        "bio": "Kitap sever • Kahve bağımlısı ☕",
        "photo": "https://i.pravatar.cc/150?img=47",
      },
      {
        "name": "Ali",
        "bio": "Seyahat • Spor • Müzik",
        "photo": "https://i.pravatar.cc/150?img=12",
      },
      {
        "name": "Selin",
        "bio": "Film geceleri & sahil yürüyüşü 🌙",
        "photo": "https://i.pravatar.cc/150?img=39",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Shuffle"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: users.length,
        itemBuilder: (context, i) {
          final u = users[i];

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(14),

              // Fotoğraf Solda
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(u["photo"]),
              ),

              // İsim + Bio Ortada
              title: Text(
                u["name"],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                u["bio"],
                style: const TextStyle(color: Colors.white70),
              ),

              // 📩 Mesaj butonu SAĞDA
              trailing: IconButton(
                icon: const Icon(
                  Icons.message_rounded,
                  color: Colors.blueAccent,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatScreen(
                        myName:
                            "Ben", // giriş yapan kullanıcı (sonradan backend)
                        targetUser: u["name"], // seçilen kişi
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
