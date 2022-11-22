import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:worksheet_browser/pages/dismissible_page_demo.dart';
import 'package:worksheet_browser/theme/theme.dart';
import 'package:worksheet_browser/widgets/my_custom_scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: MyTheme.getLightTheme(),
      home: ScrollConfiguration(
        behavior: MyCustomScrollBehavior(),
        child: const DismissiblePageDemo(),
      ),
    )
  );
}
