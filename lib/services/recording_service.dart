import 'package:record/record.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class RecordingService {
  final AudioRecorder _recorder = AudioRecorder();
  String? _currentPath;

  Future<String?> startRecording({String? fileName}) async {
    if (await _recorder.hasPermission()) {
      final dir = await getApplicationDocumentsDirectory();
      _currentPath = '${dir.path}/${fileName ?? 'recording_${DateTime.now().millisecondsSinceEpoch}'}.m4a';

      await _recorder.start(
        const RecordConfig(),
        path: _currentPath!,
      );

      return _currentPath; // هون رجعنا الباث
    }
    return null; // ما في صلاحية
  }

  Future<String?> stopRecording() async {
    await _recorder.stop();
    return _currentPath; // رجع آخر باث سجلنا عليه
  }
}
