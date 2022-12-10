import 'package:flutter/material.dart';
import 'package:stack_board/stack_board.dart';
import 'package:worksheet_browser/models/resource_item.dart';

class TextCase extends StackBoardItem {
  const TextCase({
    required this.item,
  }) : super(child: const SizedBox());
  final ResourceItem item;

  @override // <==== must
  TextCase copyWith({
    int? id,
    Widget? child,
    Future<bool> Function()? onDel,
    CaseStyle? caseStyle,
    bool? tapToEdit,
  }) => TextCase(item: item);
}