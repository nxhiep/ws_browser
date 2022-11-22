import 'package:worksheet_browser/models/models.dart';
import 'package:worksheet_browser/widgets/widgets.dart';
import 'package:flutter/widgets.dart';

class StoryPage extends StatelessWidget {
  final StoryModel story;
  final VoidCallback nextGroup;
  final VoidCallback previousGroup;

  const StoryPage({
    Key? key,
    required this.story,
    required this.nextGroup,
    required this.previousGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onTap(TapUpDetails details) async {
      final dx = details.globalPosition.dx;
      final width = MediaQuery.of(context).size.width;
      if (dx < width / 2) return previousGroup();
      return nextGroup();
    }

    return GestureDetector(
      onTapUp: _onTap,
      child: StoryImage(story, isFullScreen: true),
    );
  }
}
