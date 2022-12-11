import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:worksheet_browser/helper/ex_value_builder.dart';
import 'package:worksheet_browser/helper/get_size.dart';
import 'package:worksheet_browser/helper/safe_state.dart';
import 'package:worksheet_browser/helper/set_value_notifier.dart';
import 'package:worksheet_browser/models/resource_item.dart';

class ResourceItemWidget extends StatefulWidget {
  final ResourceItem item;
  final BoxConstraints constants;
  const ResourceItemWidget({Key? key, required this.item, required this.constants}) : super(key: key);

  @override
  State<ResourceItemWidget> createState() => _ResourceItemWidgetState();
}

class _ResourceItemWidgetState extends State<ResourceItemWidget> with SafeState<ResourceItemWidget> {

  ResourceItem get item => widget.item;
  late SafeValueNotifier<ResourceItem> _resourceItem;

  @override
  void initState() {
    super.initState();
    _resourceItem = SafeValueNotifier<ResourceItem>(ResourceItem.init(""));
  }

  void _changeSize(Size size) {
    
  }

  void _moveHandle(DragUpdateDetails dud, BoxConstraints constants) {
    ResourceItem newItem = ResourceItem.copyWith(_resourceItem.value);
    final double angle = newItem.rotation;
    final double sinA = math.sin(-angle);
    final double cosA = math.cos(-angle);
    Offset d = dud.delta;
    d = Offset(sinA * d.dy + cosA * d.dx, cosA * d.dy - sinA * d.dx);
    final Offset realOffset = Offset(newItem.x, newItem.y).translate(d.dx, d.dy);
    if(realOffset.dx >= 0 && realOffset.dx <= (constants.maxWidth - newItem.width) 
      && realOffset.dy >= 0 && realOffset.dy <= (constants.maxHeight - newItem.height)) {
      newItem.x = realOffset.dx;
      newItem.y = realOffset.dy;
      _resourceItem.value = newItem;
    }
  }

  final List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.amber, Colors.indigo, Colors.cyanAccent];

  @override
  Widget build(BuildContext context) {
    return ExValueBuilder<ResourceItem>(
      valueListenable: _resourceItem,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanUpdate: (DragUpdateDetails d) => _moveHandle(d, widget.constants),
        child: Container(
          width: item.width,
          height: item.height,
          color: colors[math.Random().nextInt(colors.length)],
        ),
      ),
      builder: (context, value, child) {
        if(value == null || child == null) {
          return const SizedBox();
        }
        return Positioned(
          top: value.y,
          left: value.x,
          child: Transform.rotate(
            angle: value.rotation,
            child: GetSize(
              onChange: (size) => size != null ? _changeSize(size) : () {},
              child: child
            )
          ),
        );
      },
    );
  }
}