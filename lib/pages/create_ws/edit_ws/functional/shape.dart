import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/provider/shape.provider.dart';
import 'package:worksheet_browser/widgets/loading.dart';

class ShapeFunctional extends StatefulWidget {
  final void Function(String imageUrl) onSelectedImage;
  const ShapeFunctional({ Key? key, required this.onSelectedImage }) : super(key: key);

  @override
  State<ShapeFunctional> createState() => _ShapeFunctionalState();
}

class _ShapeFunctionalState extends State<ShapeFunctional> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      Provider.of<ShapeProvider>(context, listen: false).loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShapeProvider>(
      builder: (context, value, child) {
        if(value.loading) {
          return const LoadingWidget();
        }
        return MasonryGridView.count(
          padding: const EdgeInsets.all(12),
          scrollDirection: Axis.vertical,
          crossAxisCount: 4,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          itemCount: value.imageUrls.length,
          itemBuilder: (context, index) {
            String imageUrl = value.imageUrls[index];
            return InkWell(
              onTap: () => widget.onSelectedImage(imageUrl),
              child: SvgPicture.network(imageUrl)
            );
          },
        );
      },
    );
  }
}