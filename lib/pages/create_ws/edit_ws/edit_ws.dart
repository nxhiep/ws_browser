import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_board/stack_board.dart';
import 'package:worksheet_browser/helper/ex_value_builder.dart';
import 'package:worksheet_browser/helper/get_size.dart';
import 'package:worksheet_browser/helper/safe_state.dart';
import 'package:worksheet_browser/helper/set_value_notifier.dart';
import 'package:worksheet_browser/models/resource_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/menu.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_case/shape_case.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_case/text_case.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/provider/edit_ws.provider.dart';

class EditWSPage extends StatefulWidget {
  const EditWSPage({ Key? key }) : super(key: key);

  @override
  State<EditWSPage> createState() => _EditWSPageState();
}

class _EditWSPageState extends State<EditWSPage> {

  late StackBoardController _controller;
  Widget? background;

  @override
  void initState() {
    super.initState();
    _controller = StackBoardController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (p0, constants) {
            return Selector<EditWSProvider, List<ResourceItem>>(
              selector: (p0, p1) => p1.resourceItems,
              builder: (context, value, child) {
                print("value ${value.length}");
                return Stack(
                  children: value.map((e) => ResourceItemWidget(item: e, constants: constants)).toList(),
                );
              },
            );
          }
        ),
        // child: StackBoard(
        //   background: background ?? const SizedBox(),
        //   controller: _controller,
        //   customBuilder: (StackBoardItem item) {
        //     return ItemWidget(item: item);
        //   },
        // )
      ),
      floatingActionButton: FloatingActionButton.extended(
        // onPressed: _showBottomSheet, 
        onPressed: () {
          Provider.of<EditWSProvider>(context, listen: false).addItem(ResourceItem.createShape("", ""));
        }, 
        label: const Icon(Icons.more_horiz)
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context, 
      builder: (context) => MyMenuWidget(
        addItem: (StackBoardItem item) {
          print('item $item');
          if(item is TextCase) {
            _controller.add<TextCase>(item);
          } else if(item is ShapeCase) {
            _controller.add<ShapeCase>(item);
          }
        },
        onChangedBackground: (Widget widget) => setState(() => background = widget)
      )
    );
  }
}

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