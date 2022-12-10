import 'package:flutter/foundation.dart';
import 'package:worksheet_browser/data/network/apis/get_api.dart';

class BackgroundProvider extends ChangeNotifier {
  List<String> backgrounds = [];
  bool loading = false;

  void loadData() async {
    loading = true;
    notifyListeners();
    backgrounds = (await GetApi().getPhotos(20)).map((e) => e.getImageRegular()).toList();
    loading = false;
    notifyListeners();
  }

  void loadMore() async {
    backgrounds.addAll((await GetApi().getPhotos(10)).map((e) => e.getImageRegular()).toList());
    notifyListeners();
  }
}