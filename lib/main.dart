import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:worksheet_browser/pages/create_ws/create_page.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/edit_ws.dart';
import 'package:worksheet_browser/pages/create_ws/edit_ws/provider/edit_ws.provider.dart';
import 'package:worksheet_browser/pages/home_page.dart';
import 'package:worksheet_browser/pages/test_safe_state.dart';
import 'package:worksheet_browser/provider/photo_data_model.dart';
import 'package:worksheet_browser/provider/photo_item_model.dart';
import 'package:worksheet_browser/provider/worksheet_model.dart';
import 'package:worksheet_browser/theme/theme.dart';
import 'package:worksheet_browser/utils/app_utils.dart';
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
        ChangeNotifierProvider(create: (_) => WorksheetModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.getLightTheme(),
        home: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: isInDebugMode ? ChangeNotifierProvider(
            create: (_) => EditWSProvider(),
            child: const EditWSPage(),
          ) : const HomePage()
          // child: const TestSafeState()
        )
      ),
    );
  }
}