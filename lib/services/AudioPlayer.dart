import 'package:audioplayers/audio_cache.dart';


class AudioPlayer {
  static AudioCache player = AudioCache();
  AudioPlayer() {
//    player.load('dice.mp3');
//    player.load('eat.wav');
//    player.load('move.wav');
//    player.load('msg.wav');
//    player.load('win.wav');
//    player.load('yourTurn.wav');
  }

  play(String name) {
    player.play(name);
  }

}
