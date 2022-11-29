import 'package:flutter/material.dart';
import 'package:worksheet_browser/models/photo.dart';

class PhotoModel extends ChangeNotifier {
  Map<String, List<Photo>> mapData = new Map<String, List<Photo>>();
}