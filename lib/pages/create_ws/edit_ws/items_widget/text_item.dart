import 'package:flutter/material.dart';
import 'package:stack_board/stack_board.dart';
import 'package:worksheet_browser/models/resource_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_case/text_case.dart';
import 'package:worksheet_browser/utils/color_utils.dart';

class TextItem extends StatefulWidget {
  final TextCase item;
  final void Function()? onDel;
  final void Function()? onTap;
  const TextItem({Key? key, required this.item, this.onDel, this.onTap}) : super(key: key);

  @override
  State<TextItem> createState() => _TextItemState();
}

class _TextItemState extends State<TextItem> {

  bool _isEditing = false;
  ResourceItem get item => widget.item.item;
  late String _text;
  TextStyle get _style => TextStyle(
    fontFamily: item.fontFamily,
    fontSize: item.fontSize,
    color: HexColor(item.fontColor),
  );

  @override
  void initState() {
    super.initState();
    _text = item.name;
  }

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
      tapToEdit: true,
      position: Offset(item.x, item.y),
      size: Size(item.width, item.height),
      rotation: item.rotation,
      child: _isEditing ? _buildEditingBox : _buildTextBox,
      onOperatStateChanged: (OperatState s) {
        if (s != OperatState.editing && _isEditing) {
          setState(() => _isEditing = false);
        } else if (s == OperatState.editing && !_isEditing) {
          setState(() => _isEditing = true);
        }
        return;
      },
    );
  }

  Widget get _buildTextBox {
    return Container(
      width: item.width,
      height: item.height,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        _text,
        style: _style,
      ),
    );
  }

  Widget get _buildEditingBox {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: SizedBox(
        width: item.width,
        height: item.height,
        child: TextFormField(
          autofocus: true,
          initialValue: _text,
          onChanged: (String v) => _text = v,
          style: _style,
        ),
      ),
    );
  }
}