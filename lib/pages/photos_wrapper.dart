import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/gestures.dart';
import 'package:worksheet_browser/models/photo.dart';
import 'package:worksheet_browser/pages/photo_page.dart';
import 'package:worksheet_browser/pages/story_page.dart';
import 'package:worksheet_browser/widgets/cubic_page_view.dart';
import 'package:flutter/material.dart';

class Config {
  static const Duration transitionDuration = Duration(milliseconds: 250);
  static const Duration reverseTransitionDuration = Duration(milliseconds: 250);
  static const bool isFullScreen = false;
  static const bool disabled = false;
  static const double startingOpacity = 1;
  static const double minScale = .7;
  static const double minRadius = 12;
  static const double maxRadius = 30;
  static const double maxTransformValue = .5;
  static const double dragSensitivity = .7;
  static const Color backgroundColor = Colors.black;
  static const DismissiblePageDismissDirection direction = DismissiblePageDismissDirection.down;
  static const Map<DismissiblePageDismissDirection, double> dismissThresholds = <DismissiblePageDismissDirection, double>{};
  static const DragStartBehavior dragStartBehavior = DragStartBehavior.down;
  static const Duration reverseDuration = Duration(milliseconds: 200);
  static const HitTestBehavior behavior = HitTestBehavior.opaque;
}

class PhotosWrapper extends StatefulWidget {
  final int parentIndex;
  final List<Photo> photos;

  const PhotosWrapper({
    Key? key,
    required this.parentIndex,
    required this.photos,
  }) : super(key: key);

  @override
  _PhotosWrapperState createState() => _PhotosWrapperState();
}

class _PhotosWrapperState extends State<PhotosWrapper>
    with TickerProviderStateMixin {
  late int dWidth;
  late PageController pageCtrl;

  List<Photo> get photos => widget.photos;

  bool get isLastPage => photos.length == pageCtrl.page!.round() + 1;

  @override
  void initState() {
    pageCtrl = PageController(initialPage: widget.parentIndex);
    super.initState();
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
    if (pageCtrl.page!.round() == 0) return Navigator.pop(context);
    previous();
  }

  void next() {
    pageCtrl.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  void previous() {
    pageCtrl.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () => Navigator.of(context).pop(),
      isFullScreen: Config.isFullScreen,
      minRadius: Config.minRadius,
      maxRadius: Config.maxRadius,
      dragSensitivity: Config.dragSensitivity,
      maxTransformValue: Config.maxTransformValue,
      direction: Config.direction,
      disabled: Config.disabled,
      backgroundColor: Config.backgroundColor,
      dismissThresholds: Config.dismissThresholds,
      dragStartBehavior: Config.dragStartBehavior,
      minScale: Config.minScale,
      startingOpacity: Config.startingOpacity,
      behavior: Config.behavior,
      reverseDuration: Config.reverseDuration,
      onDragUpdate: (d) => print(d.offset.dy),
      child: PageView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return PhotoPage(
            photo: photos[index],
            // nextGroup: nextPage,
            // previousGroup: previousPage,
            nextGroup: () {
            },
            previousGroup: () {
            },
            onUpdate: (double value) {
              pageCtrl.jumpTo(value);
            },
          );
        },
      ),
      // child: CubicPageView(
      //   controller: pageCtrl,
      //   children: photos.map((photo) {
      //     return PhotoPage(
      //       photo: photo,
      //       // nextGroup: nextPage,
      //       // previousGroup: previousPage,
      //       nextGroup: () {
      //       },
      //       previousGroup: () {
      //       },
      //       onUpdate: (double value) {
      //         pageCtrl.jumpTo(value);
      //       },
      //     );
      //   }).toList(),
      // ),
    );
  }
}
