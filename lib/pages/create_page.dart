import 'package:flutter/material.dart';

class CreateWorkSheetPage extends StatefulWidget {
  const CreateWorkSheetPage({ Key? key }) : super(key: key);

  @override
  State<CreateWorkSheetPage> createState() => _CreateWorkSheetPageState();
}

class _CreateWorkSheetPageState extends State<CreateWorkSheetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text("CreateWorkSheetPage"),
      ),
    );
  }
}