import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  final String title;

  const AudioPlayerWidget({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget>  with AutomaticKeepAliveClientMixin {
  late final AudioPlayer _player;
  bool _isLooping = false;
  double _volume = 1.0;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _player.setUrl(widget.url);
    _player.playerStateStream.listen((_) => setState(() {}));
    _player.positionStream.listen((pos) => setState(() => _position = pos));
    _player.durationStream.listen((dur) => setState(() => _duration = dur ?? Duration.zero));
  }

  @override
    bool get wantKeepAlive => true;

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _toggleLoop() {
    setState(() {
      _isLooping = !_isLooping;
      _player.setLoopMode(_isLooping ? LoopMode.one : LoopMode.off);
    });
  }

  void _restart() {
    _player.seek(Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final isPlaying = _player.playing;
    final progress = _duration.inMilliseconds > 0
        ? _position.inMilliseconds / _duration.inMilliseconds
        : 0.0;

    return Card(
      color: Colors.grey[900],
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 18)),
            Slider(
              value: progress.clamp(0.0, 1.0),
              onChanged: (v) => _player.seek(Duration(milliseconds: (_duration.inMilliseconds * v).toInt())),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(_isLooping ? Icons.repeat_one : Icons.repeat, color: _isLooping ? Colors.amber : Colors.white),
                  onPressed: _toggleLoop,
                ),
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () => isPlaying ? _player.pause() : _player.play(),
                ),
                IconButton(
                  icon: const Icon(Icons.restart_alt),
                  onPressed: _restart,
                ),
              ],
            ),
            Slider(
              value: _volume,
              onChanged: (v) {
                setState(() => _volume = v);
                _player.setVolume(v);
              },
              min: 0,
              max: 1,
            ),
          ],
        ),
      ),
    );
  }
}