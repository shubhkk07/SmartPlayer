import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:smartlisten/model/song_model.dart';

class SongRepo {
  final _dio = Dio();

  Future getSongs({String? term}) async {
    try {
      final Response response = await _dio.get("https://itunes.apple.com/search",
          queryParameters: {"media": "music", "explicit": true, "entity": "song", "term": term ?? "arijit singh", "limit": 10});

      if (response.statusCode == 200) {
        List<SongModel> songs = [];
        final data = jsonDecode(response.data);
        final List<dynamic> songList = data['results'];
        songs = songList.map((e) => SongModel.fromJson(e)).toList();
        return songs;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
