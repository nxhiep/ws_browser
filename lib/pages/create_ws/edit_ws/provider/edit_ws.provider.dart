import 'package:flutter/widgets.dart';
import 'package:worksheet_browser/models/resource_item.dart';

class EditWSProvider extends ChangeNotifier {
  List<ResourceItem> resourceItems = [];

  void addItem(ResourceItem resourceItem) {
    resourceItems = [...resourceItems, resourceItem];
    notifyListeners();
  }

}