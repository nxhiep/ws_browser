import 'package:flutter/widgets.dart';
import 'package:worksheet_browser/models/resource_item.dart';

class EditWSProvider extends ChangeNotifier {
  List<ResourceItem> resourceItems = [];

  void addItem(ResourceItem resourceItem) {
    if(resourceItem.id.isEmpty) {
      resourceItem.id = resourceItems.length.toString();
    }
    resourceItems = [...resourceItems, resourceItem];
    notifyListeners();
  }

  void removeItem(ResourceItem item) {
    List<ResourceItem> list = [...resourceItems];
    list.removeWhere(((element) => element.id == item.id));
    resourceItems = list;
    notifyListeners();
  }

}