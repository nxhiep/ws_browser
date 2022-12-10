import 'package:flutter/foundation.dart';

class ShapeProvider extends ChangeNotifier {
  List<String> imageUrls = [];
  bool loading = false;

  void loadData() async {
    loading = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 500));
    imageUrls = List.generate(10, (index) => "https://storage.googleapis.com/worksheetzone/images/shape_${index + 1}.svg");
    loading = false;
    notifyListeners();
  }
}