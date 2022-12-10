import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:worksheet_browser/data/network/constants/endpoints.dart';
import 'package:worksheet_browser/models/photo.dart';

const bool getDataFromLocal = true;

class GetApi {
  final http.Client _client = http.Client();

  Future<List<Photo>> getPhotosFromLocal(int limit) async {
    String fileName = "data.json";
    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/$fileName');
    if(await file.exists()) {
      String text = await file.readAsString();
      List<dynamic> maps = jsonDecode(text);
      maps.sort((a, b) => Random().nextInt(3) - 1);
      return maps.sublist(0, (limit != -1 && limit < maps.length) ? limit : maps.length)
        .map((dynamic e) => Photo.fromJson(e)).toList();
    }
    return [];
  }

  void savePhotos(List<Photo> photos) async {
    String fileName = "data.json";
    List<Photo> oldPhotos = await this.getPhotosFromLocal(-1);
    Map<String, Photo> mapOldPhoto = {};
    for(Photo photo in oldPhotos) {
      mapOldPhoto[photo.id] = photo;
    }
    for(Photo photo in photos) {
      if(!mapOldPhoto.containsKey(photo.id)) {
        mapOldPhoto.putIfAbsent(photo.id, () => photo);
      }
    }
    String data = jsonEncode(mapOldPhoto.values.toList().map((e) => e.toJson()).toList());
    await saveJson(fileName, data);
  }

  Future<void> saveJson(String name, String data) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/$name');
      debugPrint('saveJsonData ${file.path}');
      await file.writeAsString(data);
    } catch(e){
      debugPrint('saveJsonData Error: $e');
    }
  }

  Future<List<Photo>> getPhotos(int limit) async {
    if(getDataFromLocal) {
      return await getPhotosFromLocal(limit);
    }
    try {
      final res = await _client.get(Uri.parse(Endpoints.getPhotoUrl(limit)));
      if(res.statusCode == 200) {
        List<dynamic> maps = jsonDecode(res.body);
        List<Photo> photos = maps.map((dynamic e) => Photo.fromJson(e)).toList();
        savePhotos(photos);
        return photos;
      }
      return [];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}