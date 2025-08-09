// lib/services/playback_service.dart
import 'package:audioplayers/audioplayers.dart';

class PlaybackService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> playAsset(String assetPath) async {
    await _player.stop();
    await _player.play(AssetSource(assetPath));
  }

  Future<void> playFile(String filePath) async {
    await _player.stop();
    await _player.play(DeviceFileSource(filePath));
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Stream<PlayerState> get onPlayerStateChanged => _player.onPlayerStateChanged;
  Stream<Duration?> get onDurationChanged => _player.onDurationChanged;
  Stream<Duration> get onPositionChanged => _player.onPositionChanged;
}
