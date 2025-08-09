import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/hadith.dart';
import '../presenters/hadith_presenter.dart';
import '../services/recording_service.dart';
import '../services/playback_service.dart';
import '../widgets/transcription_box.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/transcription_result.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({Key? key}) : super(key: key);

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  final hadith = Hadith(
    id: '1',
    title: 'عن أمير المؤمنين أبي حفص عمر بن الخطاب',
    audioAssetPath: 'audio/hadith1.mp3', 
    originalText:
        'قال: سمعتُ رسولَ اللهِ ﷺ يقولُ: "إنَّما الأعمالُ بالنِّيَّات، وإنَّما لامرئٍ ما نوى، فمَن كانت هجرتُه إلى اللهِ ورسولِه، فهجرتُه إلى اللهِ ورسولِه، ومَن كانت هجرتُه لدُنيا يُصيبُها، أوِ امرأةٍ يَنكِحُها، فهجرتُه إلى ما هاجرَ إليه".',
  );

  final presenter = HadithPresenter();
  final recordingService = RecordingService();
  final playbackService = PlaybackService();

  final TextEditingController _controller = TextEditingController();

  bool _isRecording = false;
  bool _isPlayingRecorded = false;
  String? _recordedPath;
  double? _lastScore;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onPlayHadith() async {
    await presenter.playHadith(hadith);
  }


Future<void> _onPlayRecorded() async {
  if (_recordedPath == null || !File(_recordedPath!).existsSync()) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('لا يوجد تسجيل للاستماع إليه')),
    );
    return;
  }

  if (_isPlayingRecorded) {
    await playbackService.stop();
    setState(() {
      _isPlayingRecorded = false;
    });
  } else {
    await playbackService.playFile(_recordedPath!);
    setState(() {
      _isPlayingRecorded = true;
    });
  }
}

Future<void> _onRecordToggle() async {
  if (_isRecording) {
    final path = await recordingService.stopRecording();
    setState(() {
      _isRecording = false;
      _recordedPath = path;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم إيقاف التسجيل وحفظ الملف')),
    );
  } else {
    final startedPath = await recordingService.startRecording();
    if (startedPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى منح صلاحية الميكروفون')),
      );
      return;
    }
    setState(() {
      _isRecording = true;
      _recordedPath = startedPath;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('بدأ التسجيل')),
    );
  }
}


  Future<void> _onSave() async {
    if (_recordedPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('لا يوجد تسجيل لحفظه')));
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final TranscriptionResult result = await presenter.transcribeRecording(_recordedPath!, hadith.originalText);
      _controller.text = result.text;
      _lastScore = result.similarity;
      Navigator.of(context).pop(); 
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم التفريغ وعرض النص')));
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('خطأ أثناء التفريغ: $e')));
    }
  }

  void _onShowResult() {
    final edited = _controller.text;
    final score = presenter.calculateSimilarity(hadith.originalText, edited);
    setState(() {
      _lastScore = score;
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('نتيجة التسميع'),
        content: Text('نسبة التطابق: ${(score * 100).toStringAsFixed(2)}%'),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('إغلاق')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F3),
      appBar: AppBar(
        backgroundColor: const Color(0xFF009CA6),
        elevation: 0,
        title: const Text('حديث النيات'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: [
                  Text('150', style: TextStyle(color: Colors.teal[700], fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, color: Colors.amber, size: 18),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.teal[700])),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEFEFEF),
                foregroundColor: Colors.black87,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _onPlayHadith,
              icon: const Icon(Icons.volume_up, color: Color(0xFF009CA6)),
              label: const Text('استمع للحديث النبوي !', style: TextStyle(fontWeight: FontWeight.w600)),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFE8F6F8), borderRadius: BorderRadius.circular(16)),
              child: Text(hadith.title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF009688))),
            ),
          ),
          const SizedBox(height: 12),
        Expanded(
  child: EditableTranscriptionBox(
    controller: _controller,
    originalText: hadith.originalText,
    onTextChanged: (newText) {
      setState(() {
        _lastScore = presenter.calculateSimilarity(hadith.originalText, newText);
      });
    },
  ),
),

if (_lastScore != null)
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Text(
      'نسبة التطابق الحالية: ${(_lastScore! * 100).toStringAsFixed(2)}%',
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),


          if (_lastScore != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('نسبة التطابق الحالية: ${(_lastScore! * 100).toStringAsFixed(2)}%', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: _onShowResult,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF009CA6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('عرض النتيجة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onPlayHadith: _onPlayHadith,
        onRecordToggle: _onRecordToggle,
        onPlayRecorded: _onPlayRecorded,
        onSave: _onSave,
        isRecording: _isRecording,
        isPlayingRecorded: _isPlayingRecorded,
      ),
    );
  }
}
