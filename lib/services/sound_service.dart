import 'package:audioplayers/audioplayers.dart';

class SoundService {
  final AudioPlayer _player = AudioPlayer();

  final List<String> sounds = [
    'sounds/tono2.wav',
    'sounds/tono3.wav',
    'sounds/tono2.wav',
    'sounds/tono3.wav',
  ];

  Future<void> playSound(int index) async {
    await _player.stop();
    await _player.setVolume(1.0);
    await _player.play(AssetSource(sounds[index]));
  }
  

}
