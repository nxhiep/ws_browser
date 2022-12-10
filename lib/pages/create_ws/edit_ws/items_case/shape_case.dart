import 'package:flutter/material.dart';
import 'package:stack_board/stack_board.dart';
import 'package:worksheet_browser/models/resource_item.dart';

class ShapeCase extends StackBoardItem {
  const ShapeCase({
    required this.item,
  }) : super(child: const SizedBox());
  final ResourceItem item;

  @override // <==== must
  ShapeCase copyWith({
    int? id,
    Widget? child,
    Future<bool> Function()? onDel,
    CaseStyle? caseStyle,
    bool? tapToEdit,
  }) => ShapeCase(item: item);
}