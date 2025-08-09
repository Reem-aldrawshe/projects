import 'package:flutter/material.dart';

class AudioDialog extends StatelessWidget {
  final VoidCallback onListen;
  const AudioDialog({super.key, required this.onListen});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('تنويه !'),
      content: const Text(
          'قد يرد في هذا الحديث مفردات لها عدة قراءات، يرجى الاستماع للحديث'),
      actions: [
        TextButton(
          child: const Text('استماع'),
          onPressed: () {
            Navigator.pop(context);
            onListen();
          },
        )
      ],
    );
  }
}
