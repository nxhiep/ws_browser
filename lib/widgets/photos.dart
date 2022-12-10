import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:worksheet_browser/models/photo_data_item.dart';
import 'package:worksheet_browser/widgets/auto_list_view.dart';
import 'package:worksheet_browser/widgets/photo/item.dart';
import 'package:worksheet_browser/widgets/photo/wrapper.dart';

class MyGridView extends StatelessWidget {

  final List<PhotoDataItem> photos;
  final VoidCallback onLoadMore;
  final VoidCallback onRefresh;
  const MyGridView({ Key? key, required this.photos, required this.onLoadMore, required this.onRefresh }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoListView(
      onLoadMore: onLoadMore,
      onRefresh: onRefresh,
      child: MasonryGridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return PhotoItem(
            photo: photos[index], 
            onTap: () => onTapImage(context, photos[index])
          );
        },
      ),
    );
  }

  void onTapImage(BuildContext context, PhotoDataItem photo) {
    context.pushTransparentRoute(
      PhotosWrapper(photo: photo),
    );
  }
}