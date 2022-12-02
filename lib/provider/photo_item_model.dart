import 'package:flutter/material.dart';
import 'package:worksheet_browser/data/network/apis/get_api.dart';
import 'package:worksheet_browser/models/photo.dart';
import 'package:worksheet_browser/models/photo_data_item.dart';

class PhotoItemModel with ChangeNotifier {

  bool loading = false;
  PhotoDataItem? photoItem;

  void loadData(PhotoDataItem photoItem) async {
    this.photoItem = photoItem;
    if(photoItem.relatives == null) {
      loading = true;
      notifyListeners();
      List<Photo> photos = await GetApi().getPhotos(5);
      this.photoItem!.relatives = photos.map((photo) => PhotoDataItem(index: photos.indexOf(photo), photo: photo)).toList();
      for(PhotoDataItem photo in this.photoItem!.relatives!) {
        photo.brothers = this.photoItem!.relatives;
      }
      loading = false;
      notifyListeners();
    }
  }

  void loadMore(PhotoDataItem photoItem) async {
    this.photoItem = photoItem;
    List<Photo> photos = await GetApi().getPhotos(5);
    List<PhotoDataItem> list = photos.map((photo) => PhotoDataItem(index: photos.indexOf(photo), photo: photo)).toList();
    for(PhotoDataItem photo in list) {
      photo.brothers = this.photoItem!.relatives;
    }
    this.photoItem!.relatives!.addAll(list);
    notifyListeners();
  }
}