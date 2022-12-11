import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/helper/safe_state.dart';
import 'package:worksheet_browser/models/resource_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/new_items/item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/provider/edit_ws.provider.dart';

class ShapeItem extends StatefulWidget {
  final ResourceItem item;
  final BoxConstraints constraints;
  const ShapeItem({Key? key, required this.item, required this.constraints}) : super(key: key);

  @override
  State<ShapeItem> createState() => _ShapeItemState();
}

class _ShapeItemState extends State<ShapeItem> with SafeState<ShapeItem> {

  ResourceItem get item => widget.item;
  String get url => item.url;

  @override
  Widget build(BuildContext context) {
    return ElementItem(
      constraints: widget.constraints,
      item: widget.item,
      canEdit: true,
      tapToEdit: true,
      onDel: () {
        Provider.of<EditWSProvider>(context, listen: false).removeItem(item);
      },
      child: SvgPicture.network(url, width: item.width, height: item.height),
    );
  }
}