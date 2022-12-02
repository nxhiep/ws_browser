import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:worksheet_browser/models/photo_data_item.dart';
import 'package:worksheet_browser/widgets/loading.dart';

class PhotoItem extends StatelessWidget {
  final PhotoDataItem photo;
  final VoidCallback onTap;
  const PhotoItem({ Key? key, required this.photo, required this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Hero(
            tag: photo.key,
            child: Material(
              color: Colors.transparent,
              child: CachedNetworkImage(
                imageUrl: photo.photo.getImageRegular(),
                placeholder: (context, url) => const LoadingWidget(),
                errorWidget: (context, error, stackTrace) => Image.asset("assets/images/photo_not_found.png"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}