import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:worksheet_browser/data/network/apis/get_api.dart';
import 'package:worksheet_browser/models/photo.dart';
import 'package:worksheet_browser/pages/photo_item.dart';
import 'package:worksheet_browser/widgets/loading.dart';

class PhotoImage extends StatefulWidget {
  final Photo photo;

  const PhotoImage(this.photo, { Key? key }) : super(key: key);

  @override
  _PhotoImageState createState() => _PhotoImageState();
}

class _PhotoImageState extends State<PhotoImage> {

  List<Photo> _relativePhotos = [];

  @override
  void initState() {
    super.initState();
    GetApi().getPhotos(10).then((value) {
      setState(() {
        _relativePhotos = value..removeWhere((element) => element.id == widget.photo.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Hero(
            tag: widget.photo.id,
            child: Material(
              color: Colors.transparent,
              // child: _makeContent1(),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Stack(
                    children: [
                      _makeContent2(constraints),
                      _makeBackButton(),
                    ],
                  );
                }
              )
            ),
          ),
          _makeListPhotos(),
        ],
      ),
    ); 
  }

  Widget _makeMenuBG(BoxConstraints constraints) {
    return Positioned(
      width: constraints.maxWidth,
      height: 70,
      top: 0,
      left: 0,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.red,
          gradient: LinearGradient(
            colors: [
              Colors.black38,
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
      ),
    );
  }

  Widget _makeMenuButton() {
    return Positioned(
      width: 70,
      height: 70,
      top: 0,
      right: 0,
      child: IconButton(onPressed: () {
                
      }, icon: const Icon(Icons.more_horiz, color: Colors.white)),
    );
  }

  Widget _makeBackButton() {
    return Positioned(
      width: 70,
      height: 70,
      top: 0,
      left: 0,
      child: IconButton(onPressed: () {
        Navigator.pop(context);
      }, icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
    );
  }

  Widget _makeContent2(BoxConstraints constraints) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(237, 241, 248, 1),
          ),
          child: CachedNetworkImage(
            imageUrl: widget.photo.getImageRegular(),
            placeholder: (context, child) => const LoadingWidget(),
            errorWidget: (context, error, stackTrace) => Image.asset("assets/images/photo_not_found.png"),
          ),
        ),
        _makeMenuBG(constraints),
        _makeMenuButton(),
      ],
    );
  }

  Widget _makeListPhotos() {
    if(_relativePhotos.isEmpty) {
      return const SizedBox();
    }
    return StaggeredGrid.count(
      crossAxisCount: 2,
      children: _relativePhotos.map((photo) {
        return PhotoItem(
          photo: photo, 
          onTap: () {
          }
        );
      }).toList(),
    );
  }
}