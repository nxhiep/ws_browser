
import 'package:flutter/material.dart';

class TextsFunctional extends StatelessWidget {

  final void Function(double size) onSelectedText;
  const TextsFunctional({ Key? key, required this.onSelectedText }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tap to add text"),
        InkWell(
          onTap: () => onSelectedText(30),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey.withOpacity(0.3),
            child: const Text("Add a heading", style: TextStyle(fontSize: 30)),
          ),
        ),
        InkWell(
          onTap: () => onSelectedText(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey.withOpacity(0.3),
            child: const Text("Add a heading", style: TextStyle(fontSize: 20)),
          ),
        ),
        InkWell(
          onTap: () => onSelectedText(16),
          child: Container(
            padding: const EdgeInsets.all(20),
            color: Colors.grey.withOpacity(0.3),
            child: const Text("Add a heading", style: TextStyle(fontSize: 16)),
          ),
        )
      ],
    );
  }
}