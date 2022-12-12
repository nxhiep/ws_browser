import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/models/resource_item.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/background.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/config.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/shape.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/text.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/functional/upload.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/provider/background.provider.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/provider/shape.provider.dart';

class MyMenuWidget extends StatefulWidget {
  final void Function(ResourceItem item) addItem;
  final void Function(Widget widget) onChangedBackground;
  const MyMenuWidget({ Key? key, required this.addItem, required this.onChangedBackground }) : super(key: key);

  @override
  State<MyMenuWidget> createState() => _MyMenuWidgetState();
}

class _MyMenuWidgetState extends State<MyMenuWidget> {

  FunctionalID? currentFunctionalID;
  List<Functional> get functionaries => getFunctions();

  @override
  void initState() {
    super.initState();
    currentFunctionalID = functionaries.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.blue,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: functionaries.map((item) {
                    return InkWell(
                      onTap: () => setState(() => currentFunctionalID = item.id),
                      child: Container(
                        color: currentFunctionalID == item.id ? Colors.black26 : Colors.transparent,
                        width: 90,
                        child: Column(
                          children: [
                            Icon(item.icon, color: Colors.white),
                            Text(item.name, style: const TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    );
                  }).toList()
                ),
              ),
            ),
            Expanded(child: _makeContent())
          ],
        ),
      ),
    );
  }

  Widget _makeContent() {
    if(currentFunctionalID == FunctionalID.background) {
      return ChangeNotifierProvider(
        create: (_) => BackgroundProvider(),
        builder: (context, child) {
          return BackgroundFunctional(
            onSelectedColor: (color) {
              widget.onChangedBackground(Container(color: color));
            },
            onSelectedImage: (image) {
              widget.onChangedBackground(CachedNetworkImage(imageUrl: image, fit: BoxFit.fill));
            },
          );
        }
      );
    }
    if(currentFunctionalID == FunctionalID.text) {
      return TextsFunctional(
        onSelectedText: (size) {
          widget.addItem(ResourceItem.createText(size, ''));
        },
      );
    }
    if(currentFunctionalID == FunctionalID.shape) {
      return ChangeNotifierProvider(
        create: (_) => ShapeProvider(),
        builder: (context, child) {
          return ShapeFunctional(
            onSelectedImage: (imageUrl) {
              widget.addItem(ResourceItem.createShape(imageUrl, ''));
            },
          );
        }
      );
    }
    if(currentFunctionalID == FunctionalID.upload) {
      return const UploadFunctional();
    }
    // return GridView.builder(
    //   padding: const EdgeInsets.all(12),
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12),
    //   itemCount: 100,
    //   itemBuilder: (context, index) {
    //     return Container(
    //       width: 100,
    //       height: 100,
    //       color: Colors.red,
    //       child: Text(currentFunctionalID?.name ?? ""),
    //     );
    //   },
    // );
    return const Center(
      child: Text("Not available!"),
    );
  }
}