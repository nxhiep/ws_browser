
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/provider/background.provider.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/provider/template.provider.dart';
import 'package:worksheet_browser/widgets/auto_list_view.dart';
import 'package:worksheet_browser/widgets/loading.dart';

class TemplateFunctional extends StatefulWidget {
  const TemplateFunctional({ Key? key }) : super(key: key);

  @override
  State<TemplateFunctional> createState() => _TemplateFunctionalState();
}

class _TemplateFunctionalState extends State<TemplateFunctional> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      Provider.of<TemplateProvider>(context, listen: false).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Text("Default background color:"),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Colors.blue, Colors.green, Colors.red, Colors.amber, 
                    Colors.yellow, Colors.cyan, Colors.brown, Colors.blue, 
                    Colors.green, Colors.red, Colors.amber, Colors.yellow,
                    Colors.cyan, Colors.brown, Colors.blue, Colors.green,
                  ].map((color) {
                    return InkWell(
                      // onTap: () => widget.onSelectedColor(color),
                      child: Container(
                        color: color,
                        width: 40,
                        height: 40,
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Consumer<BackgroundProvider>(
            builder: (context, value, child) {
              if(value.loading) {
                return const LoadingWidget();
              }
              return AutoListView(
                onLoadMore: () => value.loadMore(),
                onRefresh: () => value.loadData(),
                child: MasonryGridView.count(
                  padding: const EdgeInsets.all(12),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  itemCount: value.backgrounds.length,
                  itemBuilder: (context, index) {
                    String imageUrl = value.backgrounds[index];
                    return InkWell(
                      // onTap: () => widget.onSelectedImage(imageUrl),
                      child: CachedNetworkImage(imageUrl: imageUrl)
                    );
                  },
                ),
              );
            }
          ),
        )
      ],
    );
  }
}