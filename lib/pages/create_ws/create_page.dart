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
                      _controller.add(
                        const AdaptiveText(
                          'text',
                          tapToEdit: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
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