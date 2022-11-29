import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:worksheet_browser/models/photo.dart';
import 'package:worksheet_browser/pages/photo_item.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:worksheet_browser/pages/photos_wrapper.dart';

class MyGridView extends StatefulWidget {

  final List<Photo> photos;
  const MyGridView({ Key? key, required this.photos }) : super(key: key);

  @override
  State<MyGridView> createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {

  List<Photo> get photos => widget.photos;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      mainAxisSpacing: 1,
      crossAxisSpacing: 1,
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return PhotoItem(
          photo: photos[index], 
          onTap: () => onTapImage(photos[index], index)
        );
      },
    );
  }

  void onTapImage(Photo photo, index) {
    context.pushTransparentRoute(
      PhotosWrapper(
        parentIndex: index,
        photos: photos,
      ),
    );
  }
}