
import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String assetPath) async {
    await _player.setAsset(assetPath);
    _player.play();
  }

  Future<void> stop() async {
    await _player.stop();
  }
}
