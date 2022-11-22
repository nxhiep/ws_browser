import 'dart:math';

import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:worksheet_browser/models/models.dart';
import 'package:worksheet_browser/widgets/google_fonts.dart';
import 'package:worksheet_browser/widgets/widgets.dart';

class DismissiblePageDemo extends StatefulWidget {
  const DismissiblePageDemo({Key? key}) : super(key: key);

  @override
  _DismissiblePageDemoState createState() => _DismissiblePageDemoState();
}

class _DismissiblePageDemoState extends State<DismissiblePageDemo> {
  final DismissiblePageModel pageModel = DismissiblePageModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _stories(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: max(20, MediaQuery.of(context).padding.top)),
            Text('Bool Parameters'),
            Wrap(spacing: 10, runSpacing: 10, children: [
              AppChip(
                onSelected: () => setState(
                    () => pageModel.isFullScreen = !pageModel.isFullScreen),
                isSelected: pageModel.isFullScreen,
                title: 'isFullscreen',
              ),
              AppChip(
                onSelected: () =>
                    setState(() => pageModel.disabled = !pageModel.disabled),
                isSelected: pageModel.disabled,
                title: 'disabled',
              ),
            ]),
            SizedBox(height: 20),
            Text('Dismiss Direction'),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: DismissiblePageDismissDirection.values.map((item) {
                return AppChip(
                  onSelected: () {
                    setState(() => pageModel.direction = item);
                  },
                  isSelected: item == pageModel.direction,
                  title: '$item'
                      .replaceAll('DismissiblePageDismissDirection.', ''),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stories() {
    return Padding(
      padding: EdgeInsets.only(
        top: 5,
        bottom: max(24, MediaQuery.of(context).padding.bottom),
      ),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final width = constraints.maxWidth;
          final itemHeight = width / 3;
          final itemWidth = width / 4;
          return SizedBox(
            height: itemHeight,
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, int index) {
                final item = pageModel.stories.elementAt(index);
                return SizedBox(
                  width: itemWidth,
                  child: StoryWidget(
                    story: item,
                    pageModel: pageModel,
                  ),
                );
              },
              separatorBuilder: (_, int i) => SizedBox(width: 10),
              itemCount: pageModel.stories.length,
            ),
          );
        },
      ),
    );
  }
}

class AppChip extends StatelessWidget {
  final VoidCallback onSelected;
  final bool isSelected;
  final String title;

  AppChip({
    required this.onSelected,
    required this.isSelected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      onSelected: (_) => onSelected(),
      selected: isSelected,
      label: Text(
        title,
        style: GoogleFonts.poppins(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

const imageUrl =
    'https://user-images.githubusercontent.com/26390946/156333539-29aefaf2-5f42-4414-8d8c-1ecbae40c377.png';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(228, 217, 236, 1),
      body: GestureDetector(
        onTap: () {
          // Use extension method to use [TransparentRoute]
          // This will push page without route background
          context.pushTransparentRoute(SecondPage());
        },
        child: Center(
          child: SizedBox(
            width: 200,
            // Hero widget is needed to animate page transition
            child: Hero(
              tag: 'Unique tag',
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () {
        Navigator.of(context).pop();
      },
      // Note that scrollable widget inside DismissiblePage might limit the functionality
      // If scroll direction matches DismissiblePage direction
      // direction: DismissiblePageDismissDirection.multi,
      onDragUpdate: (s) {
        print(s);
      },
      isFullScreen: false,
      child: Hero(
        tag: 'Unique tag',
        child: Image.network(
          imageUrl,
          alignment: Alignment.bottomCenter,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
