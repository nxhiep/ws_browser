import 'package:flutter/material.dart';
import 'package:stack_board/stack_board.dart';
import 'package:worksheet_browser/helper/safe_state.dart';
import 'package:worksheet_browser/models/resource_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/new_items/item.dart';

const TextStyle _defaultStyle = TextStyle(fontSize: 20);

class TextItem extends StatefulWidget {
  final ResourceItem item;
  final BoxConstraints constraints;
  const TextItem({Key? key, required this.item, required this.constraints}) : super(key: key);

  @override
  State<TextItem> createState() => _TextItemState();
}

class _TextItemState extends State<TextItem> with SafeState<TextItem> {

  bool _isEditing = false;
  late String _text = widget.item.name;
  TextStyle get _style => _defaultStyle;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ElementItem(
      constraints: widget.constraints,
      item: widget.item,
      canEdit: true,
      // onTap: widget.onTap,
      tapToEdit: true,
      // onDel: widget.onDel,
      child: _isEditing ? _buildEditingBox : _buildTextBox,
      onOperatStateChanged: (OperatState s) {
        if (s != OperatState.editing && _isEditing) {
          safeSetState(() => _isEditing = false);
        } else if (s == OperatState.editing && !_isEditing) {
          safeSetState(() => _isEditing = true);
        }
        return;
      },
    );
  }

  Widget get _buildTextBox {
    return Padding(
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
        width: widget.item.width,
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