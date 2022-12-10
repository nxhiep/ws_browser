import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stack_board/stack_board.dart';
import 'package:worksheet_browser/models/resource_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_case/shape_case.dart';

class ShapeItem extends StatefulWidget {
  final ShapeCase item;
  final void Function()? onDel;
  final void Function()? onTap;
  const ShapeItem({Key? key, required this.item, this.onDel, this.onTap}) : super(key: key);

  @override
  State<ShapeItem> createState() => _ShapeItemState();
}

class _ShapeItemState extends State<ShapeItem> {

  ResourceItem get item => widget.item.item;

  @override
  Widget build(BuildContext context) {
    return ItemCase(
      key: Key('StackBoardItem${widget.item.id}'), // <==== must
      isCenter: false,
      onDel: widget.onDel,
      onTap: widget.onTap,
      caseStyle: const CaseStyle(
        borderColor: Colors.grey,
        iconColor: Colors.white,
      ),
      tapToEdit: false,
      position: Offset(item.x, item.y),
      size: Size(item.width, item.height),
      rotation: item.rotation,
      child: SvgPicture.network(item.url, width: item.width, height: item.height),
    );
  }
}