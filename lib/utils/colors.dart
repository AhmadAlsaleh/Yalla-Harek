// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static const COLOR_SECONDARY = Color(0xff0d659f);
  static const COLOR_TEXT_GRAY = Color(0xFF4C4C4C);
  static const COLOR_ARC_GRAY = Color.fromARGB(255, 121, 121, 121);
  static const COLOR_LIGHT_GRAY = Color(0xffd9d9d9);
  static const COLOR_RED = Color(0xFFDF1515);
  static const COLOR_BLACK = Color(0xFF0E0E0E);
  static const COLOR_ICON_GRAY = Color.fromARGB(255, 211, 211, 211);

  static const MaterialColor primaryColors =
      MaterialColor(_primaryValue, <int, Color>{
    50: Color(0xFFF1E4E4),
    100: Color(0xFFDCBCBD),
    200: Color(0xFFC58F91),
    300: Color(0xFFAE6264),
    400: Color(0xFF9C4043),
    500: Color(_primaryValue),
    600: Color(0xFF831A1E),
    700: Color(0xFF781619),
    800: Color(0xFF6E1214),
    900: Color(0xFF5B0A0C),
  });
  static const int _primaryValue = 0xFF8B1E22;

  static const MaterialColor colorsAccent =
      MaterialColor(_colorsAccentValue, <int, Color>{
    100: Color(0xFFFF8F90),
    200: Color(_colorsAccentValue),
    400: Color(0xFFFF292C),
    700: Color(0xFFFF0F13),
  });
  static const int _colorsAccentValue = 0xFFFF5C5E;
}
