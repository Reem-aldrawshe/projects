import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final VoidCallback onListen;
  final VoidCallback onStopListen;
  final VoidCallback onStartRecording;
  final VoidCallback onStopRecording;
  final VoidCallback onPlayRecorded;
  final VoidCallback onSave;
  final bool isPlaying;
  final bool isRecording;

  const BottomNavBar({
    super.key,
    required this.onListen,
    required this.onStopListen,
    required this.onStartRecording,
    required this.onStopRecording,
    required this.onPlayRecorded,
    required this.onSave,
    required this.isPlaying,
    required this.isRecording,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.volume_up, color: isPlaying ? Colors.teal[700] : Colors.grey),
            onPressed: isPlaying ? onStopListen : onListen,
            tooltip: 'استماع',
          ),
          IconButton(
            icon: Icon(isRecording ? Icons.stop : Icons.mic, color: isRecording ? Colors.red : Colors.grey),
            onPressed: isRecording ? onStopRecording : onStartRecording,
            tooltip: 'تسميع',
          ),
          IconButton(
            icon: Icon(Icons.play_circle_filled, color: Colors.grey),
            onPressed: onPlayRecorded,
            tooltip: 'استماع التسجيل',
          ),
          IconButton(
            icon: Icon(Icons.save, color: Colors.grey),
            onPressed: onSave,
            tooltip: 'حفظ',
          ),
        ],
      ),
    );
  }
}