// import 'package:just_audio/just_audio.dart';

// class PlaybackService {
//   final AudioPlayer _player = AudioPlayer();
//   Stream<Duration?> get durationStream => _player.durationStream;
//   Stream<Duration> get positionStream => _player.positionStream;
//   Stream<PlayerState> get playerStateStream => _player.playerStateStream;

//  Future<void> playAsset(String assetPath) async {
//   await _player.stop();    
//   await _player.setAsset(assetPath);
//   await _player.play();
// }

// Future<void> playFile(String filePath) async {
//   await _player.stop();   
//   await _player.setFilePath(filePath);
//   await _player.play();
// }


//   Future<void> pause() async {
//     await _player.pause();
//   }

//   Future<void> stop() async {
//     await _player.stop();
//   }

//   Future<void> seek(Duration position) async {
//     await _player.seek(position);
//   }

//   bool get isPlaying => _player.playing;
// }

import 'package:just_audio/just_audio.dart';

class PlaybackService {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get audioPlayer => _player; // ← هاد اضفناه

  Stream<Duration?> get durationStream => _player.durationStream;
  Stream<Duration> get positionStream => _player.positionStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  Future<void> playAsset(String assetPath) async {
    await _player.stop();    
    await _player.setAsset(assetPath);
    await _player.play();
  }

  Future<void> playFile(String filePath) async {
    await _player.stop();   
    await _player.setFilePath(filePath);
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  bool get isPlaying => _player.playing;
}
