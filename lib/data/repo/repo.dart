import 'package:music_app/data/src/source.dart';

import '../model/song.dart';

abstract interface class Repo {
  Future<List<Song>?> loadData();
}
class DefaultRepo implements Repo{
  final _localDataSrc = LocalDataSource();
  final _remoteDataSrc = RemoteDataSource();

  @override
  Future<List<Song>?> loadData() async {
    List<Song> songs = [];
    List<Song>? remoteSongs = await _remoteDataSrc.loadData();
      if(remoteSongs == null){
        List<Song>? localSongs = await _localDataSrc.loadData();
          if(localSongs != null){
            songs.addAll(localSongs);
          }
      } else  {
          songs.addAll(remoteSongs);
      }
    return songs;
  }}