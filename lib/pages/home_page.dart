import 'package:flutter/material.dart';
import 'package:worksheet_browser/data/network/apis/get_api.dart';
import 'package:worksheet_browser/models/photo.dart';
import 'package:worksheet_browser/pages/my_grid_view.dart';
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
        child: _photos.isEmpty ? const LoadingWidget() : MyGridView(
          photos: _photos
        ),
      ),
    );
  }
}