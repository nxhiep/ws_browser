
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stack_board/stack_board.dart';
import 'package:worksheet_browser/models/resource_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/menu.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_case/shape_case.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/items_case/text_case.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/new_items/text_item.dart';
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
          builder: (p0, constraints) {
            return Selector<EditWSProvider, List<ResourceItem>>(
              selector: (p0, p1) => p1.resourceItems,
              builder: (context, value, child) {
                return Stack(
                  // children: value.map((e) => ResourceItemWidget(item: e, constants: constraints)).toList(),
                  children: value.map((e) => TextItem(
                    item: e, 
                    constraints: constraints,
                  )).toList(),
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
          Provider.of<EditWSProvider>(context, listen: false).addItem(ResourceItem.createText(20, ""));
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