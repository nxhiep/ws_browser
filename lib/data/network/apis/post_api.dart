import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:worksheet_browser/data/network/constants/endpoints.dart';
import 'package:worksheet_browser/models/photo.dart';

class PostApi {
  final http.Client _client = http.Client();

  Future<List<Photo>> getPhotos(int limit) async {
    try {
      final res = await _client.get(Uri.parse(Endpoints.getPhotoUrl(limit)));
      if(res.statusCode == 200) {
        List<dynamic> maps = jsonDecode(res.body);
        return maps.map((e) => Photo.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}