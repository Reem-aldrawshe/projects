import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/hadith.dart';
import '../services/recording_service.dart';
import '../services/playback_service.dart';
import '../presenters/hadith_presenter.dart';
import '../models/transcription_result.dart';
import 'audio_dialog.dart';
import 'bottom_nav_bar.dart';
import 'transcription_box.dart';

class HadithDetailsInteractivePage extends StatefulWidget {
  final int startIndex;

  const HadithDetailsInteractivePage({super.key, this.startIndex = 0});

  @override
  State<HadithDetailsInteractivePage> createState() =>
      _HadithDetailsInteractivePageState();
}

class _HadithDetailsInteractivePageState
    extends State<HadithDetailsInteractivePage> {
  late int currentIndex;

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

  Hadith get currentHadith => arbaoonHadiths[currentIndex];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.startIndex;

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

  void _resetStates() {
    _controller.clear();
    _lastScore = null;
    _showResult = false;
    _isPlaying = false;
    _isPlayingRecorded = false;
    _isRecording = false;
    _recordedPath = null;
    _recordDuration = Duration.zero;
    playbackService.stop();
    recordingService.stopRecording();
  }

  Future<void> _playHadith() async {
    await playbackService.stop();
    await playbackService.playAsset(currentHadith.audioAssetPath);
    setState(() {
      _isPlaying = true;
      _isPlayingRecorded = false;
    });
  }

  Future<void> _playRecordedFile() async {
    if (_recordedPath == null || !File(_recordedPath!).existsSync()) return;
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

  Future<void> _onRecordToggle() async {
    if (_isRecording) {
      final path = await recordingService.stopRecording();
      setState(() {
        _isRecording = false;
        _recordedPath = path;
      });
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
    }
  }

  Future<void> _onSave() async {
    if (_recordedPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يوجد تسجيل لحفظه')),
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final result = await presenter.transcribeRecording(
        _recordedPath!,
        currentHadith.originalText,
      );
      _controller.text = result.text;

      Navigator.of(context).pop();
      setState(() {
        _showResult = false;
      });
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ أثناء التفريغ: $e')),
      );
    }
  }

  void _onShowResult() {
    final edited = _controller.text;
    final score = presenter.calculateSimilarity(
      currentHadith.originalText,
      edited,
    );
    setState(() {
      _lastScore = score;
      _showResult = true;
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes.remainder(60))}:${twoDigits(d.inSeconds.remainder(60))}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF1F3),
      appBar: AppBar(
        backgroundColor: const Color(0xff088395),
        title: Text('حديث رقم ${currentHadith.id}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: currentIndex > 0
                ? () {
                    setState(() {
                      currentIndex--;
                      _resetStates();
                    });
                  }
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: currentIndex < arbaoonHadiths.length - 1
                ? () {
                    setState(() {
                      currentIndex++;
                      _resetStates();
                    });
                  }
                : null,
          ),
        ],
      ),
      body: Column(
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
                      AudioDialog(audioAssetPath: currentHadith.audioAssetPath),
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
                    child: const Text(
                      '150',
                      style: TextStyle(
                        color: Color(0xffF4862C),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    ' ! سمّع الحديث النبوي  ',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color(0xff8F8D7D),
                      fontSize: 18,
                    ),
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
                currentHadith.title,
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
              originalText: currentHadith.originalText,
              onTextChanged: (newText) {
                setState(() {
                  _lastScore = presenter.calculateSimilarity(
                    currentHadith.originalText,
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        onPlayHadith: _playHadith,
        onRecordToggle: _onRecordToggle,
        onPlayRecorded: _playRecordedFile,
        onSave: _onSave,
        isRecording: _isRecording,
        isPlayingRecorded: _isPlayingRecorded,
      ),
    );
  }
}
