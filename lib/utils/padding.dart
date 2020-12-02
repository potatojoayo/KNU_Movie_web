import 'package:flutter/material.dart';

class MyPadding {
  static const double largeHorizontal = 250;
  static const double normalHorizontal = 30;
  static mediaWidth(context) {
    return MediaQuery.of(context).size.width / 7;
  }
}
