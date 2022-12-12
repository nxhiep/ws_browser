
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/models/resource_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/config.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/menu.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/new_items/shape_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/new_items/text_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/provider/edit_ws.provider.dart';

class EditWSPage extends StatefulWidget {
  const EditWSPage({ Key? key }) : super(key: key);

  @override
  State<EditWSPage> createState() => _EditWSPageState();
}

class _EditWSPageState extends State<EditWSPage> {

  Widget? background;
  late EditWSProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<EditWSProvider>(context, listen: false);
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
                List<Widget> _list = value.map((e) {
                    if(e.type == FunctionalID.shape.index) {
                      return ShapeItem(item: e, constraints: constraints);
                    }
                    return TextItem(
                      item: e, 
                      constraints: constraints,
                    );
                  }).toList();
                if(background != null) {
                  _list.add(background!);
                }
                return Stack(
                  // children: value.map((e) => ResourceItemWidget(item: e, constants: constraints)).toList(),
                  children: _list,
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
        onPressed: _showBottomSheet, 
        // onPressed: () {
        //   Provider.of<EditWSProvider>(context, listen: false).addItem(ResourceItem.createText(20, ""));
        // }, 
        label: const Icon(Icons.more_horiz)
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context, 
      builder: (context) => MyMenuWidget(
        addItem: (ResourceItem item) {
          print("xxxxx");
          provider.addItem(item);
        },
        onChangedBackground: (Widget widget) => setState(() => background = widget)
      )
    );
  }
}