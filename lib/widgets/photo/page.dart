import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/models/photo_data_item.dart';
import 'package:worksheet_browser/provider/photo_item_model.dart';
import 'package:worksheet_browser/widgets/loading.dart';
import 'package:worksheet_browser/widgets/photo/image.dart';
import 'package:worksheet_browser/widgets/photos.dart';

class PhotoPage extends StatefulWidget {
  final PhotoDataItem photo;
  const PhotoPage({ Key? key, required this.photo }) : super(key: key);

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {

  late int dWidth;
  late PageController _pageController;
  PhotoDataItem get photoItem => widget.photo;
  List<PhotoDataItem> get photos => photoItem.brothers!;
  bool get isLastPage => photos.length == _pageController.page!.round() + 1;

  @override
  void initState() {
    _pageController = PageController(initialPage: photoItem.index);
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<PhotoItemModel>(context, listen: false).loadData(photoItem);
    });
  }

  @override
  void didChangeDependencies() {
    dWidth = MediaQuery.of(context).size.width.floor();
    super.didChangeDependencies();
  }

  void nextPage() {
    if (isLastPage) return Navigator.pop(context);
    next();
  }

  void previousPage() {
    if (_pageController.page!.round() == 0) return Navigator.pop(context);
    previous();
  }

  void next() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  void previous() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const ClampingScrollPhysics(),
      controller: _pageController,
      itemCount: photos.length,
      onPageChanged: (index) {
        Provider.of<PhotoItemModel>(context, listen: false).loadData(photos[index]);
      },
      itemBuilder: (context, index) {
        return Stack(
          children: [
            PhotoImage(photo: photos[index]),
            _makeListPhoto()
          ],
        );
      },
    );
  }

  Widget _makeListPhoto() {
    return Consumer<PhotoItemModel>(
      builder: (context, value, child) {
        List<PhotoDataItem>? items = value.photoItem?.relatives;
        if(value.loading || items == null) {
          return const LoadingWidget();
        }
        return MyGridView(
          photos: items,
            onLoadMore: () {
              Provider.of<PhotoItemModel>(context, listen: false).loadMore(photoItem);
            },
            onRefresh: () {
              Provider.of<PhotoItemModel>(context, listen: false).loadData(photoItem);
            },
        );
      },
    );
  }
}