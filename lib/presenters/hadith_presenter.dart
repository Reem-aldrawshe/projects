import '../models/hadith.dart';
import '../models/transcription_result.dart';
import '../services/recording_service.dart';
import '../services/playback_service.dart';
import '../services/transcription_service.dart';
import '../utils/similarity_utils.dart';

class HadithPresenter {
  final RecordingService _recordingService = RecordingService();
  final PlaybackService _playbackService = PlaybackService();

  Future<void> playHadith(Hadith hadith) async {
    await _playbackService.playAsset(hadith.audioAssetPath);
  }

  Future<void> stopPlayback() async {
    await _playbackService.stop();
  }

  Future<String?> startRecording({String? fileName}) {
    return _recordingService.startRecording(fileName: fileName);
  }

  Future<String?> stopRecording() {
    return _recordingService.stopRecording();
  }

  Future<void> playRecorded(String path) async {
    await _playbackService.playFile(path);
  }

  Future<void> stopRecordedPlayback() async {
    await _playbackService.stop();
  }

  Future<TranscriptionResult> transcribeRecording(
    String filePath,
    String originalText,
  ) async {
    final text = await TranscriptionService.uploadAndTranscribe(filePath);
    final score = SimilarityUtils.calculateSimilarity(originalText, text);
    return TranscriptionResult(text: text, similarity: score);
  }

  double calculateSimilarity(String original, String spoken) {
    return SimilarityUtils.calculateSimilarity(original, spoken);
  }
}
