import 'package:flutter/material.dart';

class GoogleFonts {
  static TextStyle poppins({ double? fontSize, FontWeight? fontWeight, Color? color }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color ?? Colors.black
    );
  }

}