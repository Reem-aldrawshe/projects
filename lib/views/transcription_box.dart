import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class EditableTranscriptionBox extends StatefulWidget {
  final TextEditingController controller;
  final String originalText;
  final Function(String) onTextChanged;

  const EditableTranscriptionBox({
    Key? key,
    required this.controller,
    required this.originalText,
    required this.onTextChanged,
  }) : super(key: key);

  @override
  State<EditableTranscriptionBox> createState() => _EditableTranscriptionBoxState();
}

class _EditableTranscriptionBoxState extends State<EditableTranscriptionBox> {
  late List<String> words;

  @override
  void initState() {
    super.initState();
    words = widget.controller.text.trim().isNotEmpty
        ? widget.controller.text.trim().split(RegExp(r'\s+'))
        : [];
  }

  void _updateWord(int index, String newWord) {
    setState(() {
      words[index] = newWord;
      final newText = words.join(' ');
      widget.controller.text = newText;
      widget.onTextChanged(newText);
      widget.controller.selection = TextSelection.fromPosition(TextPosition(offset: newText.length));
    });
  }

  Future<void> _editWordDialog(int index) async {
    final controller = TextEditingController(text: words[index]);

    final editedWord = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تعديل الكلمة'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'عدل الكلمة'),
          onSubmitted: (value) {
            Navigator.of(context).pop(value.trim());
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(controller.text.trim()),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );

    if (editedWord != null && editedWord.isNotEmpty) {
      _updateWord(index, editedWord);
    }
  }

  @override
  Widget build(BuildContext context) {
    words = widget.controller.text.trim().isNotEmpty
        ? widget.controller.text.trim().split(RegExp(r'\s+'))
        : [];

    return SizedBox(
      height: 150,
      width: 330,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        constraints: BoxConstraints(minHeight: 120, maxHeight: 180),
        child: SingleChildScrollView(
          child: RichText(
            textDirection: TextDirection.rtl,
            text: TextSpan(
              children: List.generate(words.length, (index) {
                return TextSpan(
                  text: words[index] + (index == words.length - 1 ? '' : ' '),
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      _editWordDialog(index);
                    },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
