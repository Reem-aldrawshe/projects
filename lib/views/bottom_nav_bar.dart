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
      color: Color(0xff088395),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.volume_up),
              onPressed: onPlayHadith,
              tooltip: 'استمع للحديث',
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(
                isRecording ? Icons.stop_circle : Icons.mic,
                color: isRecording ? Colors.red : Colors.white,
              ),
              onPressed: onRecordToggle,
              tooltip: isRecording ? 'إيقاف التسجيل' : 'ابدأ التسجيل',
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(
                isPlayingRecorded ? Icons.pause_circle_filled : Icons.play_circle_fill,
                color: isPlayingRecorded ? Colors.teal : Colors.white,
              ),
              onPressed: onPlayRecorded,
              tooltip: isPlayingRecorded ? 'إيقاف الاستماع' : 'استمع لتسجيلك',
            ),
            IconButton(
              color: Colors.white,
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
