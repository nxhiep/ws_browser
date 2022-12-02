import 'package:flutter/material.dart';
import 'package:worksheet_browser/data/network/apis/get_api.dart';
import 'package:worksheet_browser/models/photo.dart';
import 'package:worksheet_browser/models/photo_data_item.dart';

class PhotosDataModel extends ChangeNotifier {
  bool loading = false;
  List<PhotoDataItem> photoDataItems = [];

  void loadData() async {
    loading = true;
    notifyListeners();
    List<Photo> photos = await GetApi().getPhotos(10);
    photoDataItems = photos.map((photo) => PhotoDataItem(index: photos.indexOf(photo), photo: photo)).toList();
    for(PhotoDataItem photo in photoDataItems) {
      photo.brothers = photoDataItems;
    }
    loading = false;
    notifyListeners();
  }

  void loadMore() async {
    List<Photo> photos = await GetApi().getPhotos(10);
    List<PhotoDataItem> list = photos.map((photo) => PhotoDataItem(index: photos.indexOf(photo), photo: photo)).toList();
    for(PhotoDataItem photo in list) {
      photo.brothers = photoDataItems;
    }
    photoDataItems.addAll(list);
    notifyListeners();
  }
}