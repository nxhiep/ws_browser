import 'package:flutter/foundation.dart';
import 'package:stack_board/stack_board.dart';

class WorksheetModel extends ChangeNotifier {
  final StackBoardController controller = StackBoardController();
  
  void addText() {
    // controller.add(StackBoardItem(
    //   child: Image.network( 'https://avatars.githubusercontent.com/u/47586449?s=200&v=4'),
    // ));
  }
}