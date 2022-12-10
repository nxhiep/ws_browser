import 'package:flutter/material.dart';
import 'package:worksheet_browser/helper/safe_state.dart';

class TestSafeState extends StatefulWidget {
  const TestSafeState({Key? key}) : super(key: key);

  @override
  State<TestSafeState> createState() => _TestSafeStateState();
}

class _TestSafeStateState extends State<TestSafeState> with SafeState<TestSafeState> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                count++;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              safeSetState(() {
                count--;
              });
            },
          ),
          Center(
            child: Text("$count"),
          )
        ],
      ),
    );
  }
}