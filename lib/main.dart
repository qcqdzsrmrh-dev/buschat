import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'screens/shuffle_screen.dart';
import 'screens/chat_screen.dart';

void main() => runApp(const BusChatApp());

//════════════════════════════════════════════════════
// 🔥 ROOT APP
//════════════════════════════════════════════════════

class BusChatApp extends StatelessWidget {
  const BusChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(), // İlk ekran: Login / Signup
      onGenerateRoute: (route) {
        if (route.name == "/chat") {
          final args = route.arguments as Map?;
          return MaterialPageRoute(
            builder: (_) => ChatScreen(
              myName: args?["myName"] ?? "Ben",
              targetUser: args?["targetUser"] ?? "Anonim Kullanıcı",
            ),
          );
        }
        return null;
      },
    );
  }
}

//════════════════════════════════════════════════════
// 🔥 GİRİŞ SONRASI ANA NAVİGASYON
//════════════════════════════════════════════════════

class MainNavigation extends StatefulWidget {
  final String username; // 🔥 Profil'de gösterilecek isim

  const MainNavigation({super.key, required this.username});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      ProfilePage(username: widget.username),
      const Center(
        child: Text("Chats", style: TextStyle(color: Colors.white)),
      ),
      const ShuffleScreen(isPlusUser: false),
      const Center(
        child: Text("Story", style: TextStyle(color: Colors.white)),
      ),
      const Center(
        child: Text("Plus", style: TextStyle(color: Colors.white)),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: "Chats",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.shuffle), label: "Shuffle"),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_library_outlined),
            label: "Story",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: "Plus"),
        ],
      ),
    );
  }
}

//════════════════════════════════════════════════════
// 🔥 PROFİL SAYFASI
//════════════════════════════════════════════════════

class ProfilePage extends StatelessWidget {
  final String username; // 🔥 Dinamik kullanıcı adı

  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80),
              const CircleAvatar(radius: 50, backgroundColor: Colors.white24),
              const SizedBox(height: 14),
              Text(
                username, // 🔥 Artık buraya backend'den gelen username yazılır
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
