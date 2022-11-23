import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:worksheet_browser/data/network/apis/get_api.dart';
import 'package:worksheet_browser/models/photo.dart';
import 'package:worksheet_browser/pages/photo_item.dart';
import 'package:worksheet_browser/pages/photos_wrapper.dart';
import 'package:worksheet_browser/widgets/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late List<Photo> _photos = [];

  @override
  void initState() {
    super.initState();
    GetApi().getPhotos(30).then((value) {
      setState(() {
        _photos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: _photos.isEmpty ? const LoadingWidget() : SingleChildScrollView(
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            children: _photos.map((photo) {
              return PhotoItem(
                photo: photo,
                onTap: () {
                  context.pushTransparentRoute(
                    PhotosWrapper(
                      parentIndex: _photos.indexOf(photo),
                      photos: _photos,
                    ),
                  );
                },
              );
            }).toList()
          ),
        ),
      ),
    );
  }
}