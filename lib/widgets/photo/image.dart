import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:worksheet_browser/models/photo_data_item.dart';
import 'package:worksheet_browser/widgets/loading.dart';

class PhotoImage extends StatelessWidget {
  final PhotoDataItem photo;
  final Widget? child;
  final VoidCallback onLoadMore;
  const PhotoImage({ Key? key, required this.photo, this.child, required this.onLoadMore }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool requesting = false;
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification && notification.metrics.axis == Axis.vertical) {
          if(notification.metrics.pixels >= notification.metrics.maxScrollExtent - 300) {
            if(!requesting) {
              requesting = true;
              requesting = true;
              onLoadMore();
              Future.delayed(const Duration(seconds: 2), () => requesting = false);
            }
          }
        }
        return false;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: photo.key,
              child: Material(
                color: Colors.transparent,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      children: [
                        _makeContent(constraints),
                        _makeBackButton(context),
                      ],
                    );
                  }
                )
              ),
            ),
            _makeListPhoto() 
          ],
        ),
      ),
    );
  }

  Widget _makeListPhoto() {
    if(child == null) {
      return const SizedBox();
    }
    return child!;
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

  Widget _makeBackButton(BuildContext context) {
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

  Widget _makeContent(BoxConstraints constraints) {
    return Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(237, 241, 248, 1),
          ),
          child: CachedNetworkImage(
            imageUrl: photo.photo.getImageRegular(),
            placeholder: (context, child) => const LoadingWidget(),
            errorWidget: (context, error, stackTrace) => Image.asset("assets/images/photo_not_found.png"),
          ),
        ),
        _makeMenuBG(constraints),
        _makeMenuButton(),
      ],
    );
  }
}