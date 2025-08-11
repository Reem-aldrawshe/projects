import 'package:record/record.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

class RecordingService {
  final AudioRecorder _recorder = AudioRecorder();
  String? _currentPath;

  final _durationController = StreamController<Duration>.broadcast();
  Timer? _timer;
  Duration _currentDuration = Duration.zero;

  Stream<Duration> get recordingDurationStream => _durationController.stream;

  Future<String?> startRecording({String? fileName}) async {
    if (await _recorder.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      _currentPath = '${dir.path}/${fileName ?? 'recording_${DateTime.now().millisecondsSinceEpoch}'}.m4a';

      _currentDuration = Duration.zero;
      _durationController.add(_currentDuration);

      await _recorder.start(
        const RecordConfig(),
        path: _currentPath!,
      );

      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        _currentDuration += const Duration(seconds: 1);
        _durationController.add(_currentDuration);
      });

      return _currentPath;
    }
    return null;
  }

  Future<String?> stopRecording() async {
    await _recorder.stop();
    _timer?.cancel();
    return _currentPath;
  }
}
