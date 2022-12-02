import 'package:flutter/material.dart';
import 'package:worksheet_browser/models/photo.dart';

class PhotoDataItem {
  final UniqueKey key = UniqueKey();
  final Photo photo;
  final int index;
  List<PhotoDataItem>? brothers;
  List<PhotoDataItem>? relatives;
  PhotoDataItem({ required this.index, required this.photo });
}