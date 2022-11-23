import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:worksheet_browser/data/network/apis/get_api.dart';
import 'package:worksheet_browser/models/models.dart';
import 'package:worksheet_browser/models/photo.dart';
import 'package:worksheet_browser/pages/stories_wrapper.dart';

final DismissiblePageModel pageModel = DismissiblePageModel();

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
    GetApi().getPhotos().then((value) {
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
        child: _photos.isEmpty ? const Text("Loading...") : SingleChildScrollView(
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            children: _photos.map((photo) {
              return _Tile(photos: _photos, photo: photo, index: _photos.indexOf(photo));
            }).toList()
          ),
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final Photo photo;
  final List<Photo> photos;
  final int index;
  const _Tile({ Key? key, required this.photo, required this.photos, required this.index }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTransparentRoute(
          StoriesWrapper(
            parentIndex: index,
            pageModel: pageModel,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(photo.getImage()),
        ),
      ),
    );
  }
}