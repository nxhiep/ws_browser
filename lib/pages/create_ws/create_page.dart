import 'package:flutter/material.dart';
import 'package:stack_board/stack_board.dart';

class CreateWorkSheetPage extends StatefulWidget {
  const CreateWorkSheetPage({ Key? key }) : super(key: key);

  @override
  State<CreateWorkSheetPage> createState() => _CreateWorkSheetPageState();
}

class _CreateWorkSheetPageState extends State<CreateWorkSheetPage> {

  final StackBoardController _controller = StackBoardController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StackBoard(
                background: Container(color: Colors.grey.withOpacity(0.5)),
                controller: _controller,
                customBuilder: (item) {
                  return item.child;
                },
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  color: Colors.blue,
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      // _controller.add(const ImageCase());
                      _controller.add(const StackBoardItem(child: ImageCase()));
                    }, 
                    icon: const Icon(Icons.abc_rounded)
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  color: Colors.blue,
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      final List<ItemInfo> list = _controller.getItemInfos();
                      print(list.toString());
                    }, 
                    icon: const Icon(Icons.save)
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ImageCase extends StatefulWidget {
  const ImageCase({Key? key}) : super(key: key);

  @override
  State<ImageCase> createState() => _ImageCaseState();
}

class _ImageCaseState extends State<ImageCase> {
  @override
  Widget build(BuildContext context) {
    return ItemCase(
      child: Image.asset("assets/images/photo_not_found.png"),
    );
  }
}