import 'package:flutter/material.dart';
import 'screens/auth_screen.dart';
import 'screens/shuffle_screen.dart';
import 'screens/chat_screen.dart';

void main() => runApp(const BusChatApp());

class BusChatApp extends StatelessWidget {
  const BusChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthScreen(),

      // 🔥 Login başarılı olunca buraya düşecek
      onGenerateRoute: (settings) {
        if (settings.name == "/home") {
          final data = settings.arguments as Map?;
          return MaterialPageRoute(
            builder: (_) =>
                MainNavigation(username: data?["username"] ?? "User"),
          );
        }

        if (settings.name == "/chat") {
          final args = settings.arguments as Map?;
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

// 🔥 LOGIN sonrası açılan NAV BAR ekranı
class MainNavigation extends StatefulWidget {
  final String username;
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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.shuffle), label: "Shuffle"),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: "Story"),
          BottomNavigationBarItem(icon: Icon(Icons.star_border), label: "Plus"),
        ],
      ),
    );
  }
}

// 🔥 PROFİL SAYFASI — Artık username backend'den geliyor
class ProfilePage extends StatelessWidget {
  final String username;
  const ProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            const CircleAvatar(radius: 50, backgroundColor: Colors.white30),
            const SizedBox(height: 15),
            Text(
              username,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
