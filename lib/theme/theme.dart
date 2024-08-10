import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      surface: Colors.grey.shade300,
      primary: Colors.grey.shade400,
      secondary: Colors.grey.shade200,
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      surface: Color(0xff121214),
      primary: Color(0xff2a2a2f),
      secondary: Color(0xff1e1e21),
    ));
