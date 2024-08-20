import 'dart:convert';
import 'package:flutter/services.dart';

import '../model/song.dart';
import 'package:http/http.dart' as http;
//https://gist.githubusercontent.com/chechminh19/ca8111e13515ac364c1fe00c47c07c92/raw/9e7caf5e3e65c8ee125b0319c0e3e8dead2f2e11/songs.json
//https://thantrieu.com/resources/braniumapis/songs.json
abstract interface class DataSource {
    Future<List<Song>?> loadData();
}
class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async  {
    const url = 'https://gist.githubusercontent.com/chechminh19/ca8111e13515ac364c1fe00c47c07c92/raw/9e7caf5e3e65c8ee125b0319c0e3e8dead2f2e11/songs.json';
    final uri = Uri.parse(url);
    final resposne = await http.get(uri);
    if(resposne.statusCode == 200){
      final bodyContent = utf8.decode(resposne.bodyBytes);
      var songWrapper = jsonDecode(bodyContent) as Map<String, dynamic>;
      var songList = songWrapper['songs'] as List;
      List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
      return songs;
    } else  {
      throw Exception('Failed to load album');
    }
  }
}
class LocalDataSource implements DataSource{
  @override
  Future<List<Song>?> loadData() async {
    final String response = await rootBundle.loadString('assests/songs.json');
    final jsonBody = jsonDecode(response) as Map;
    final songList = jsonBody['songs'] as List;
    List<Song> songs = songList.map((song) => Song.fromJson(song)).toList();
    return songs;
  }

}