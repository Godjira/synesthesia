import 'package:flutter/material.dart';
import '../widgets/audio_player_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tracks = [
      {'title': 'Ритм 1', 'url': 'https://godjira.github.io/guitar/audio/Аудіо_001.mp3'},
      {'title': 'Ритм 2', 'url': 'hhttps://godjira.github.io/guitar/audio/Аудіо_001.mp3'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Музичні вправи')),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: tracks
              .map((t) => AudioPlayerWidget(title: t['title']!, url: t['url']!))
              .toList(),
        ),
      ),
    );
  }
}