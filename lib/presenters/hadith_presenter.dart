import '../models/hadith.dart';
import '../models/transcription_result.dart';
import '../services/audio_service.dart';
import '../services/transcription_service.dart';
import '../utils/similarity_utils.dart';

class HadithPresenter {
  final AudioService _audioService = AudioService();

  Future<void> playHadith(Hadith hadith) async {
    await _audioService.play(hadith.audioAssetPath);
  }

  Future<void> stopAudio() async {
    await _audioService.stop();
  }

  Future<TranscriptionResult> handleTranscription(
    String filePath,
    String originalText,
  ) async {
    final transcribed = await TranscriptionService.uploadAndTranscribe(filePath);
    final score = SimilarityUtils.calculateSimilarity(originalText, transcribed);
    return TranscriptionResult(text: transcribed, similarity: score);
  }


  double calculateSimilarity(String original, String spoken) {
  return SimilarityUtils.calculateSimilarity(original, spoken);
}

}
