import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/pages/create_ws/create_page.dart';
import 'package:worksheet_browser/widgets/photos.dart';
import 'package:worksheet_browser/provider/photo_data_model.dart';
import 'package:worksheet_browser/widgets/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PhotosDataModel>(context, listen: false).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateWorkSheetPage()));
            }, 
            icon: const Icon(Icons.create_new_folder)
          )
        ],
      ),
      body: SafeArea(
        child: Consumer<PhotosDataModel>(
          builder: (context, value, child) {
            if(value.loading) {
              return const LoadingWidget();
            }
            return MyGridView(
              photos: value.photoDataItems,
              onLoadMore: () {
                Provider.of<PhotosDataModel>(context, listen: false).loadMore();
              },
              onRefresh: () {
                Provider.of<PhotosDataModel>(context, listen: false).loadData();
              },
            );
          }
        ),
      ),
    );
  }
}