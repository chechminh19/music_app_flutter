import 'dart:convert';
import 'package:flutter/services.dart';

import '../model/song.dart';
import 'package:http/http.dart' as http;

abstract interface class DataSource {
    Future<List<Song>?> loadData();
}
class RemoteDataSource implements DataSource {
  @override
  Future<List<Song>?> loadData() async  {
    const url = 'https://api.jsonbin.io/v3/b/66c44f78acd3cb34a876f6f4';
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