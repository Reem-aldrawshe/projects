import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final VoidCallback onPlayHadith;
  final VoidCallback onRecordToggle;
  final VoidCallback onPlayRecorded;
  final VoidCallback onSave;
  final bool isRecording;
  final bool isPlayingRecorded;

  const BottomNavBar({
    Key? key,
    required this.onPlayHadith,
    required this.onRecordToggle,
    required this.onPlayRecorded,
    required this.onSave,
    required this.isRecording,
    required this.isPlayingRecorded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.volume_up),
              onPressed: onPlayHadith,
              tooltip: 'استمع للحديث',
            ),
            IconButton(
              icon: Icon(isRecording ? Icons.stop_circle : Icons.mic, color: isRecording ? Colors.red : Colors.black54),
              onPressed: onRecordToggle,
              tooltip: isRecording ? 'إيقاف التسجيل' : 'ابدأ التسجيل',
            ),
            IconButton(
              icon: Icon(isPlayingRecorded ? Icons.stop : Icons.play_circle_fill),
              onPressed: onPlayRecorded,
              tooltip: 'استمع لتسجيلك',
            ),
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: onSave,
              tooltip: 'حفظ وارسال للتفريغ',
            ),
          ],
        ),
      ),
    );
  }
}
