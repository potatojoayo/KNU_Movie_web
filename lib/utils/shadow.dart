import 'package:flutter/material.dart';

class TextShadow {
  static Shadow textShadow() {
    return Shadow(
      color: Colors.grey[400],
      offset: Offset(3.0, 3.0),
      blurRadius: 3.0,
    );
  }
}
