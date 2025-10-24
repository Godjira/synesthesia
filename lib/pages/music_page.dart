import 'package:flutter/material.dart';
import '../widgets/audio_player_widget.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tracks = [
      {'title': 'Ритм 1', 'assetPath': 'audio/Аудіо_001.mp3'},
      {'title': 'Ритм 2', 'assetPath': 'audio/Аудіо_001.mp3'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Музичні вправи')),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: tracks
              .map((t) => AudioPlayerWidget(title: t['title']!, assetPath: t['assetPath']!))
              .toList(),
        ),
      ),
    );
  }
}