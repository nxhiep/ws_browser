import 'package:flutter/material.dart';
import 'package:worksheet_browser/constants/colors.dart';

class MyTheme {
  static ThemeData getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: MyColors.selectedColor,
        padding: const EdgeInsets.all(0),
        disabledColor: Colors.grey,
        brightness: Brightness.dark,
        labelStyle: const TextStyle(),
        secondaryLabelStyle: const TextStyle(),
        secondarySelectedColor: Colors.red
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: MyColors.activeColor,
        activeTickMarkColor: MyColors.activeColor,
        thumbColor: MyColors.activeColor,
        inactiveTrackColor: MyColors.activeColor.withOpacity(.2),
      ),
    );
  }

  static ThemeData getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        selectedColor: MyColors.selectedColor,
        padding: const EdgeInsets.all(0),
        disabledColor: Colors.grey,
        brightness: Brightness.dark,
        labelStyle: const TextStyle(),
        secondaryLabelStyle: const TextStyle(),
        secondarySelectedColor: Colors.red
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: MyColors.activeColor,
        activeTickMarkColor: MyColors.activeColor,
        thumbColor: MyColors.activeColor,
        inactiveTrackColor: MyColors.activeColor.withOpacity(.2),
      ),
    );
  }
}