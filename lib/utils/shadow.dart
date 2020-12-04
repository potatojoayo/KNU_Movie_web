import 'package:flutter/material.dart';

class TextShadow {
  static Shadow textShadow() {
    return Shadow(
      color: Colors.grey[300],
      offset: Offset(2.5, 2.5),
      blurRadius: 2.0,
    );
  }
}
