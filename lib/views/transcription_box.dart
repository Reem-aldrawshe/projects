import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import '../models/hadith.dart';
import '../presenters/hadith_presenter.dart';

class TranscriptionBox extends StatefulWidget {
  final Hadith hadith;
  final HadithPresenter presenter;

  const TranscriptionBox({super.key, required this.hadith, required this.presenter, required String transcribedText});

  @override
  State<TranscriptionBox> createState() => _TranscriptionBoxState();
}

class _TranscriptionBoxState extends State<TranscriptionBox> {
  final recorder = AudioRecorder();
  bool isRecording = false;
  String transcribed = '';
  double score = 0.0;
  String? path;

  Future<void> startRecording() async {
    final dir = await getApplicationDocumentsDirectory();
    path = '${dir.path}/recorded.wav';

    bool hasPermission = await recorder.hasPermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('يجب إعطاء صلاحية الميكروفون')));
      return;
    }

    await recorder.start(const RecordConfig(), path: path!);
    setState(() => isRecording = true);
  }

  Future<void> stopRecording() async {
    await recorder.stop();
    setState(() => isRecording = false);
  }

  Future<void> saveAndTranscribe() async {
    if (path != null) {
      final result = await widget.presenter.handleTranscription(path!, widget.hadith.originalText);
      setState(() {
        transcribed = result.text;
        score = result.similarity;
      });
    }
  }

  void editWord(int index) async {
    final wordList = transcribed.split(' ');
    final oldWord = wordList[index];
    final controller = TextEditingController(text: oldWord);

    final newWord = await showDialog<String>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('تعديل الكلمة'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'اكتب الكلمة الصحيحة'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('حفظ'),
          ),
        ],
      ),
    );

    if (newWord != null && newWord.trim().isNotEmpty) {
      setState(() {
        wordList[index] = newWord;
        transcribed = wordList.join(' ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final wordList = transcribed.split(' ');

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: isRecording ? stopRecording : startRecording,
                child: Text(isRecording ? 'إيقاف التسميع' : 'تسميع'),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: saveAndTranscribe,
                child: const Text('حفظ'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (transcribed.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(wordList.length, (index) {
                final word = wordList[index];
                return GestureDetector(
                  onTap: () => editWord(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.yellow[100],
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(word, style: const TextStyle(fontSize: 16)),
                  ),
                );
              }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final finalScore = widget.presenter.calculateSimilarity(
                  transcribed,
                  widget.hadith.originalText,
                );
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('عرض النتيجة'),
                    content: Text('نسبة التشابه: ${(finalScore * 100).toStringAsFixed(2)}%'),
                  ),
                );
              },
              child: const Text('عرض النتيجة'),
            )
          ]
        ],
      ),
    );
  }
}
