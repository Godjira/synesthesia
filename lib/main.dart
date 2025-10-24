import 'package:flutter/material.dart';
import 'pages/music_page.dart';
import 'pages/theory_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Trainer',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const MainTabs(),
    );
  }
}

class MainTabs extends StatefulWidget {
  const MainTabs({super.key});

  @override
  State<MainTabs> createState() => _MainTabsState();
}

class _MainTabsState extends State<MainTabs> {
  int _index = 0;
  final _pages = const [MusicPage(), TheoryPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          MusicPage(),
          TheoryPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.music_note), label: 'Музика'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Теорія'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}