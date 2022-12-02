import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/pages/home_page.dart';
import 'package:worksheet_browser/provider/photo_item_model.dart';
import 'package:worksheet_browser/provider/photo_data_model.dart';
import 'package:worksheet_browser/theme/theme.dart';
import 'package:worksheet_browser/widgets/my_custom_scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PhotosDataModel()),
        ChangeNotifierProvider(create: (_) => PhotoItemModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.getLightTheme(),
        home: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: const HomePage()
        )
      ),
    );
  }
}