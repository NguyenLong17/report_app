
import 'package:flutter/material.dart';

class AppColor {
  static final _app = AppColor._internal();

  factory AppColor() => _app;

  AppColor._internal();

  var isDarkMode = false;

  Color get primaryColor => isDarkMode ? Colors.amber : Colors.tealAccent;
  Color get backgroundColor => isDarkMode ? Colors.black54 : Colors.white;


}

final appColor = AppColor();
