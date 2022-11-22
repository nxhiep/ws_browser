import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:worksheet_browser/models/models.dart';
import 'package:worksheet_browser/pages/stories_wrapper.dart';
import 'package:worksheet_browser/widgets/google_fonts.dart';

class StoryWidget extends StatelessWidget {
  final StoryModel story;
  final DismissiblePageModel pageModel;

  const StoryWidget({ Key? key, required this.story, required this.pageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushTransparentRoute(
          StoriesWrapper(
            parentIndex: pageModel.stories.indexOf(story),
            pageModel: pageModel,
          ),
          transitionDuration: pageModel.transitionDuration,
          reverseTransitionDuration: pageModel.reverseTransitionDuration,
        );
      },
      child: StoryImage(story),
    );
  }
}

class StoryImage extends StatefulWidget {
  final StoryModel story;
  final bool isFullScreen;

  StoryImage(this.story, {this.isFullScreen = false});

  @override
  _StoryImageState createState() => _StoryImageState();
}

class _StoryImageState extends State<StoryImage> {
  late String imageUrl;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    imageUrl = widget.story.imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: widget.story.storyId,
      child: Material(
        color: Colors.transparent,
        child: Container(
          clipBehavior: Clip.antiAlias,
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(widget.isFullScreen ? 20 : 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.isFullScreen ? 0 : 8),
            color: Color.fromRGBO(237, 241, 248, 1),
            image: DecorationImage(
              onError: (_, __) {
                setState(() {
                  imageUrl = widget.story.altUrl;
                  hasError = true;
                });
              },
              fit: BoxFit.cover,
              image: hasError
                  ? AssetImage(widget.story.altUrl)
                  : NetworkImage(imageUrl) as ImageProvider,
            ),
          ),
          child: Text(
            widget.story.title,
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
    );
  }
}