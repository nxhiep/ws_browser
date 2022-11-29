import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({ Key? key }) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: MaterialButton(
          child: const Text("Test"),
          onPressed: () {
            show();
          }
        ),
      ),
    );
  }

  final List<Color> colors = [Colors.indigo, Colors.blue, Colors.red, Colors.yellow, Colors.purple, Colors.green, Colors.amber, Colors.teal];

  void show() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return PageView.builder(
          itemCount: colors.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(20),
              color: colors[index],
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: Column(
                  children: colors.map((e) => Container(
                    height: 200,
                    color: e,
                  )).toList(),
                ),
              ),
            );
          },
        );
        // return PageView.custom(
        //   scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        //   childrenDelegate: SliverChildBuilderDelegate((_, index) => Container(
        //     color: Colors.blue,
        //     alignment: Alignment.center,
        //     child: Text("TestPage $index"),
        //   )),
        // );
      },
    );
  }
}