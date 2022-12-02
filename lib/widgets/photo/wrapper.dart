import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:worksheet_browser/models/photo_data_item.dart';
import 'package:worksheet_browser/widgets/photo/page.dart';

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

class PhotosWrapper extends StatelessWidget {
  final PhotoDataItem photo;
  const PhotosWrapper({ Key? key, required this.photo }) : super(key: key);

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
      child: PhotoPage(photo: photo),
    );
  }
}