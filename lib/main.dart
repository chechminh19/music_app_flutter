// import 'package:flutter/material.dart';
// import 'package:music_app/data/repo/repo.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   var repo = DefaultRepo();
//   var songs = await repo.loadData();
//   if(songs != null){
//     for(var song in songs){
//       debugPrint(song.toString());
//     }
//   }else {
//     print('not found');
//   }
// }
//
// class MusicApp extends StatelessWidget {
//   const MusicApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:music_app/ui/home/home.dart';

void main() => runApp(const MusicApp());
