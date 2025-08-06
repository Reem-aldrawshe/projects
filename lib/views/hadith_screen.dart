// import 'package:flutter/material.dart';
// import '../models/hadith.dart';
// import '../presenters/hadith_presenter.dart';
// import 'audio_dialog.dart';
// import 'transcription_box.dart';

// class HadithScreen extends StatefulWidget {
//   const HadithScreen({super.key});

//   @override
//   State<HadithScreen> createState() => _HadithScreenState();
// }

// class _HadithScreenState extends State<HadithScreen> {
//   final presenter = HadithPresenter();
//   final hadith = Hadith(
//     id: '1',
//     title: 'عن أمير المؤمنين أبي حفص عمر بن الخطاب',
//     audioAssetPath: 'assets/audio/hadith1.mp3',
//     originalText: 'قال: سمعتُ رسولَ اللهِ ﷺ يقولُ: "إنَّما الأعمالُ بالنِّيَّات، وإنَّما لامرئٍ ما نوى، فمَن كانت هجرتُه إلى اللهِ ورسولِه، فهجرتُه إلى اللهِ ورسولِه، ومَن كانت هجرتُه لدُنيا يُصيبُها، أوِ امرأةٍ يَنكِحُها، فهجرتُه إلى ما هاجرَ إليه".',
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFEFF1F3),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF009CA6),
//         elevation: 0,
//         title: const Text('حديث النيات'),
//         centerTitle: true,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 12.0),
//             child: CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Icon(Icons.person, color: Colors.teal[700]),
//             ),
//           )
//         ],
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: ElevatedButton.icon(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xFFEFEFEF),
//                 foregroundColor: Colors.black87,
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (_) => AudioDialog(
//                     onListen: () async => await presenter.playHadith(hadith),
//                   ),
//                 );
//               },
//               icon: const Icon(Icons.volume_up, color: Color(0xFF009CA6)),
//               label: const Text(
//                 'استمع للحديث النبوي !',
//                 style: TextStyle(fontWeight: FontWeight.w600),
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE8F6F8),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               child: Text(
//                 hadith.title,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16,
//                   color: Color(0xFF009688),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(height: 12),
//           Expanded(
//             child: TranscriptionBox(
//               hadith: hadith,
//               presenter: presenter,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/hadith.dart';
import '../presenters/hadith_presenter.dart';
import 'audio_dialog.dart';
import 'transcription_box.dart';
import 'bottom_nav_bar.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({super.key});

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  final presenter = HadithPresenter();
  final hadith = Hadith(
    id: '1',
    title: 'عن أمير المؤمنين أبي حفص عمر بن الخطاب',
    audioAssetPath: 'assets/audio/hadith1.mp3',
    originalText: 'قال: سمعتُ رسولَ اللهِ ﷺ يقولُ: "إنَّما الأعمالُ بالنِّيَّات، وإنَّما لامرئٍ ما نوى، فمَن كانت هجرتُه إلى اللهِ ورسولِه، فهجرتُه إلى اللهِ ورسولِه، ومَن كانت هجرتُه لدُنيا يُصيبُها، أوِ امرأةٍ يَنكِحُها، فهجرتُه إلى ما هاجرَ إليه".',
  );

  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _isRecording = false;
  double _playbackPosition = 0;
  double _playbackDuration = 100;
  String _transcribedText = '';

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        setState(() {
          _isPlaying = false;
          _playbackPosition = 0;
        });
      }
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _playbackDuration = duration.inMilliseconds.toDouble();
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _playbackPosition = position.inMilliseconds.toDouble();
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playHadith() async {
    setState(() {
      _isPlaying = true;
    });
    await _audioPlayer.play(AssetSource(hadith.audioAssetPath));
  }

  Future<void> _stopHadith() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _playbackPosition = 0;
    });
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('نتيجة التسميع'),
        content: const Text('نسبة التطابق: 95%'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('إغلاق'),
          ),
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
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
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.teal[700]),
            ),
          )
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AudioDialog(
                    onListen: _playHadith,
                  ),
                );
              },
              icon: const Icon(Icons.volume_up, color: Color(0xFF009CA6)),
              label: const Text(
                'استمع للحديث النبوي !',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F6F8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                hadith.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF009688),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: TranscriptionBox(
              hadith: hadith,
              presenter: presenter,
              transcribedText: _transcribedText,
            ),
          ),
          if (_isPlaying) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Slider(
                value: _playbackPosition,
                min: 0,
                max: _playbackDuration,
                onChanged: (value) {},
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _showResultDialog,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: const Color(0xFF009CA6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('عرض النتيجة', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onListen: _playHadith,
        onStopListen: _stopHadith,
        onStartRecording: _startRecording,
        onStopRecording: _stopRecording,
        onPlayRecorded: () {},
        onSave: () {},
        isPlaying: _isPlaying,
        isRecording: _isRecording,
      ),
    );
  }
}
