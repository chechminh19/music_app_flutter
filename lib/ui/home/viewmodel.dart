import 'dart:async';
import 'package:music_app/data/repo/repo.dart';
import 'package:music_app/ui/home/home.dart';
import '../../data/model/song.dart';

class MusicAppViewModel {
  StreamController<List<Song>> songStream = StreamController();
  void loadSongs(){
    final repo = DefaultRepo();
    repo.loadData().then((value) => songStream.add(value!));
  }
}