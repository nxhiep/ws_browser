
import 'package:flutter/material.dart';
import 'package:stack_board/stack_board.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_case/shape_case.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_case/text_case.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_widget/shape_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_widget/text_item.dart';

class ItemWidget extends StatelessWidget {
  final StackBoardItem item;
  const ItemWidget({ Key? key, required this.item }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StackBoardItem temp = item;
    if(temp is TextCase) {
      return TextItem(item: temp);
    }
    if(temp is ShapeCase) {
      return ShapeItem(item: temp);
    }
    return const SizedBox();
  }
}