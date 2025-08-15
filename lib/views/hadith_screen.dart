import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:alhekma/views/audio_dialog.dart';
import '../models/hadith.dart';
import '../presenters/hadith_presenter.dart';
import '../services/recording_service.dart';
import '../services/playback_service.dart';
import 'transcription_box.dart';
import 'bottom_nav_bar.dart';
import '../models/transcription_result.dart';

class HadithScreen extends StatefulWidget {
  const HadithScreen({Key? key}) : super(key: key);

  @override
  State<HadithScreen> createState() => _HadithScreenState();
}

class _HadithScreenState extends State<HadithScreen> {
  final hadith = Hadith(
    id: '1',
    title: 'عَنْ أَمِيرِ المُؤمِنينَ أَبي حَفْصٍ عُمَرَ بْنِ الخَطَّابِ',
    audioAssetPath: 'assets/audio/hadith1.mp3',
    originalText:
        ' قَالَ : سَمِعْتُ رَسُولَ اللهِ ﷺ يَقُولُ : " إِنَّمَا الأَعْمَالُ بِالنِّيَّاتِ ، وَإنَّمَا لِكُلِّ امْرِىءٍ مَا نَوَى ، فَمَنْ كَانَتْ هِجْرَتُهُ إِلى اللهِ وَرَسُوله فَهِجْرتُهُ إلى اللهِ وَرَسُوُله ، وَمَنْ كَانَتْ هِجْرَتُهُ لِدُنْيَا يُصِيْبُهَا  أو مرأة  ينكحها فهجرته إلى ما هاجر إليه',
  );

  final presenter = HadithPresenter();
  final recordingService = RecordingService();
  final playbackService = PlaybackService();

  final TextEditingController _controller = TextEditingController();

  bool _isRecording = false;
  bool _isPlaying = false;
  bool _isPlayingRecorded = false;
  String? _recordedPath;
  bool _showResult = false;
  double? _lastScore;

  Duration _audioDuration = Duration.zero;
  Duration _audioPosition = Duration.zero;

  Duration _recordDuration = Duration.zero;

  late final Stream<Duration> _recordingDurationStream;
  late final Stream<Duration?> _playbackDurationStream;
  late final Stream<Duration> _playbackPositionStream;
  late final Stream<PlayerState> _playbackStateStream;

  @override
  void initState() {
    super.initState();

    _recordingDurationStream = recordingService.recordingDurationStream;
    _recordingDurationStream.listen((duration) {
      if (_isRecording) {
        setState(() {
          _recordDuration = duration;
        });
      }
    });

    _playbackDurationStream = playbackService.durationStream;
    _playbackPositionStream = playbackService.positionStream;
    _playbackStateStream = playbackService.playerStateStream;

    _playbackDurationStream.listen((duration) {
      if (duration != null) {
        setState(() {
          _audioDuration = duration;
        });
      }
    });

    _playbackPositionStream.listen((position) {
      if (_isPlaying) {
        setState(() {
          _audioPosition = position;
        });
      }
    });

    _playbackStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          _isPlaying = false;
          _isPlayingRecorded = false;
          _audioPosition = Duration.zero;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    playbackService.stop();
    super.dispose();
  }

  Future<void> _playHadith() async {
    await playbackService.stop();
    await playbackService.playAsset(hadith.audioAssetPath);
  }

  Future<void> _playRecordedFile() async {
    if (_recordedPath == null || !File(_recordedPath!).existsSync()) {
      return;
    }
    await playbackService.stop();
    await playbackService.playFile(_recordedPath!);
    setState(() {
      _isPlaying = true;
      _isPlayingRecorded = true;
    });
  }

  Future<void> _pausePlayback() async {
    await playbackService.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _stopPlayback() async {
    await playbackService.stop();
    setState(() {
      _isPlaying = false;
      _isPlayingRecorded = false;
      _audioPosition = Duration.zero;
    });
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying) {
      await _pausePlayback();
    } else {
      if (_isPlayingRecorded) {
        await _playRecordedFile();
      } else {
        await _playHadith();
      }
    }
  }

  Future<void> _onRecordToggle() async {
    if (_isRecording) {
      final path = await recordingService.stopRecording();
      setState(() {
        _isRecording = false;
        _recordedPath = path;
        _recordDuration = Duration.zero;
      });
    } else {
      final startedPath = await recordingService.startRecording();
      if (startedPath == null) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('يرجى منح صلاحية الميكروفون')),
          );
        }
        return;
      }
      setState(() {
        _isRecording = true;
        _recordedPath = startedPath;
        _recordDuration = Duration.zero;
      });
    }
  }

  Future<void> _onPlayRecorded() async {
    if (_recordedPath == null || !File(_recordedPath!).existsSync()) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يوجد تسجيل للاستماع إليه')),
        );
      }
      return;
    }
    if (_isPlayingRecorded) {
      await _pausePlayback();
      setState(() {
        _isPlayingRecorded = false;
        _isPlaying = false;
      });
    } else {
      setState(() {
        _isPlayingRecorded = true;
        _isPlaying = true;
      });
      await playbackService.stop();
      await playbackService.playFile(_recordedPath!);
    }
  }

  Future<void> _onSave() async {
    if (_isRecording) {
      await recordingService.stopRecording();
    }
    await _stopPlayback();

    if (_recordedPath == null) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('لا يوجد تسجيل لحفظه')));
      }
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final TranscriptionResult result = await presenter.transcribeRecording(
        _recordedPath!,
        hadith.originalText,
      );
      _controller.text = result.text;
      // _lastScore = result.similarity;    // لا تعدل النسبة هنا!

      Navigator.of(context).pop();
      setState(() {
        _showResult = false;
      });
    } catch (e) {
      Navigator.of(context).pop();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطأ أثناء التفريغ: $e')));
      }
    }
  }

  void _onShowResult() {
    final edited = _controller.text;
    final score = presenter.calculateSimilarity(hadith.originalText, edited);
    setState(() {
      _lastScore = score;
      _showResult = true;
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final min = twoDigits(d.inMinutes.remainder(60));
    final sec = twoDigits(d.inSeconds.remainder(60));
    return '$min:$sec';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F3),
      appBar: AppBar(
        backgroundColor: const Color(0xff088395),
        elevation: 0,
        title: const Text(
          'حديث النيات',
          style: TextStyle(color: Color(0xffFFFFFF)),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.teal[700]),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEFEFEF),
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) =>
                          AudioDialog(audioAssetPath: hadith.audioAssetPath),
                    );
                    setState(() {
                      _isPlaying = false;
                      _isPlayingRecorded = false;
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/feathers.png',
                              width: 18,
                              height: 18,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '150',
                              style: TextStyle(
                                color: Color(0xffF4862C),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          SizedBox(width: 8),
                          Text(
                            ' ! سمّع الحديث النبوي  ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Color(0xff8F8D7D),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    hadith.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Color(0xff61933E),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: EditableTranscriptionBox(
                  controller: _controller,
                  originalText: hadith.originalText,
                  onTextChanged: (newText) {
                    setState(() {
                      _lastScore = presenter.calculateSimilarity(
                        hadith.originalText,
                        newText,
                      );
                    });
                  },
                ),
              ),
              if (_lastScore != null) const SizedBox(height: 8),
              Center(
                child: GestureDetector(
                  onTap: _onShowResult,
                  child: Container(
                    width: 160,
                    height: 47,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: _showResult
                          ? const LinearGradient(
                              colors: [Color(0xFF09A3BA), Color(0xFF92D2DC)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                      color: _showResult ? null : const Color(0xFFBBBBBB),
                    ),
                    child: Text(
                      _showResult
                          ? 'النتيجة: ${((_lastScore ?? 0) * 100).toStringAsFixed(0)}/100'
                          : 'عرض النتيجة',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        height: 47 / 16,
                        letterSpacing: 0,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),

          if (_isPlaying && !_isRecording)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () async {
                  if (_isPlaying) {
                    await _pausePlayback();
                  } else {
                    if (_isPlayingRecorded) {
                      await _playRecordedFile();
                    } else {
                      await _playHadith();
                    }
                  }
                },
                child: Container(
                  color: Colors.blueGrey.shade100,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  child: Row(
                    children: [
                      Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                      Expanded(
                        child: Slider(
                          min: 0,
                          max: _audioDuration.inMilliseconds.toDouble().clamp(
                            1,
                            double.infinity,
                          ),
                          value: _audioPosition.inMilliseconds.toDouble().clamp(
                            0,
                            _audioDuration.inMilliseconds.toDouble(),
                          ),
                          onChanged: (val) async {
                            final pos = Duration(milliseconds: val.toInt());
                            await playbackService.seek(pos);
                          },
                        ),
                      ),
                      Text(_formatDuration(_audioPosition)),
                    ],
                  ),
                ),
              ),
            ),

          if (_isRecording)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Color(0xff96D5DE),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                child: Row(
                  children: [
                    Text(_formatDuration(_recordDuration)),
                    const SizedBox(width: 8),
                    const Text('جاري التسجيل...'),
                    const Spacer(),
                    const Icon(Icons.mic, color: Color(0xff088395)),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onPlayHadith: () async {
          setState(() {
            _isPlaying = true;
            _isPlayingRecorded = false;
          });
          await playbackService.stop();
          await _playHadith();
        },
        onRecordToggle: _onRecordToggle,
        onPlayRecorded: _onPlayRecorded,
        onSave: _onSave,
        isRecording: _isRecording,
        isPlayingRecorded: _isPlayingRecorded,
      ),
    );
  }
}
