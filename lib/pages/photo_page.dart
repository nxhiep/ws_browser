import 'package:flutter/widgets.dart';
import 'package:worksheet_browser/models/photo.dart';
import 'package:worksheet_browser/pages/photo_image.dart';

class PhotoPage extends StatelessWidget {
  final Photo photo;
  final VoidCallback nextGroup;
  final VoidCallback previousGroup;
  final Function(double value) onUpdate;

  const PhotoPage({
    Key? key,
    required this.photo,
    required this.nextGroup,
    required this.previousGroup,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    void _onTap(DragUpdateDetails details) async {
      print("details ${width - details.localPosition.dx}");
      // onUpdate(details.localPosition.dx);
      // final dx = details.globalPosition.dx;
      // if (dx < width / 2) return previousGroup(dx);
      // return nextGroup(dx);
    }
    return GestureDetector(
      onHorizontalDragUpdate: _onTap,
      onDoubleTap: () {
        print("111111");
      },
      child: PhotoImage(photo),
    );
    return PhotoImage(photo);
  }
}
