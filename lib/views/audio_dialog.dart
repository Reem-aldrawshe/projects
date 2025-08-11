// import 'package:flutter/material.dart';

// class AudioDialog extends StatelessWidget {
//   final VoidCallback onListen;
//   const AudioDialog({super.key, required this.onListen});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('تنويه !'),
//       content: const Text(
//           'قد يرد في هذا الحديث مفردات لها عدة قراءات، يرجى الاستماع للحديث'),
//       actions: [
//         TextButton(
//           child: const Text('استماع'),
//           onPressed: () {
//             Navigator.pop(context);
//             onListen();
//           },
//         )
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioDialog extends StatefulWidget {
  final String audioAssetPath;

  const AudioDialog({Key? key, required this.audioAssetPath}) : super(key: key);

  @override
  State<AudioDialog> createState() => _AudioDialogState();
}

class _AudioDialogState extends State<AudioDialog> {
  late AudioPlayer _player;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();

    _player.durationStream.listen((d) {
      if (d != null) {
        setState(() {
          _duration = d;
        });
      }
    });

    _player.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });

    _player.playerStateStream.listen((state) {
      setState(() {
        _isPlaying = state.playing;
      });
    });

    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await _player.setAsset(widget.audioAssetPath);
    } catch (e) {
      print("Error loading audio asset: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _player.pause();
    } else {
      _player.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تشغيل الحديث النبوي'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('قد يرد في هذا الحديث مفردات لها عدة قراءات، يرجى الاستماع للحديث'),
          const SizedBox(height: 20),
          Slider(
            min: 0,
            max: _duration.inMilliseconds.toDouble(),
            value: _position.inMilliseconds.clamp(0, _duration.inMilliseconds).toDouble(),
            onChanged: (value) {
              _player.seek(Duration(milliseconds: value.toInt()));
            },
            activeColor: Colors.teal,
            inactiveColor: Colors.grey[300],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle, size: 36, color: Colors.teal),
                onPressed: _togglePlayPause,
              ),
              const SizedBox(width: 12),
              Text(
                "${_formatDuration(_position)} / ${_formatDuration(_duration)}",
                style: const TextStyle(fontSize: 14),
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          child: const Text('إغلاق'),
          onPressed: () {
            _player.stop();
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
