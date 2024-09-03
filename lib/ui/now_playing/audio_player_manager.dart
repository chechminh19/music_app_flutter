import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class AudioPlayerManager {
  AudioPlayerManager._internal();
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  factory AudioPlayerManager() => _instance;

  final AudioPlayer player = AudioPlayer();
  Stream<DurationState>? durationState;
  String songUrl ="";
  
  void init({bool isNewSong = false}) {
    durationState = Rx.combineLatest2<Duration, PlaybackEvent, DurationState>(
        player.positionStream,
        player.playbackEventStream,
        (position, playBackEvent) => DurationState(
            progress: position,
            buffered: playBackEvent.bufferedPosition,
            total: playBackEvent.duration));
    if(isNewSong) {
      player.setUrl(songUrl);
    }
  }
  void updateSongUrl(String url){
    songUrl = url;
    init();
  }
  void dispose(){
    player.dispose();
  }
}

class DurationState {
  const DurationState({
    required this.progress,
    required this.buffered,
    this.total,
  });

  final Duration progress;
  final Duration buffered;
  final Duration? total;
}
