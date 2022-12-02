import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/models/photo_data_item.dart';
import 'package:worksheet_browser/provider/photo_data_model.dart';
import 'package:worksheet_browser/widgets/photo/item.dart';
import 'package:worksheet_browser/widgets/photo/wrapper.dart';

class MyGridView extends StatefulWidget {

  final List<PhotoDataItem> photos;
  final VoidCallback onLoadMore;
  final VoidCallback onRefresh;
  const MyGridView({ Key? key, required this.photos, required this.onLoadMore, required this.onRefresh }) : super(key: key);

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {

  List<PhotoDataItem> get photos => widget.photos;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool requesting = false;
    return RefreshIndicator(
      onRefresh: () async => widget.onRefresh(),
      child: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification && notification.metrics.axis == Axis.vertical) {
            if(notification.metrics.pixels >= notification.metrics.maxScrollExtent - 200) {
              if(!requesting) {
                requesting = true;
                requesting = true;
                widget.onLoadMore();
                Future.delayed(const Duration(seconds: 2), () => requesting = false);
              }
            }
          }
          return false;
        },
        child: MasonryGridView.count(
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          mainAxisSpacing: 1,
          crossAxisSpacing: 1,
          itemCount: photos.length,
          itemBuilder: (context, index) {
            return PhotoItem(
              photo: photos[index], 
              onTap: () => onTapImage(photos[index])
            );
          },
        ),
      ),
    );
  }

  void onTapImage(PhotoDataItem photo) {
    context.pushTransparentRoute(
      PhotosWrapper(photo: photo),
    );
  }
}