import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/responsive_layout.dart';

class MyText {
  Widget subTitleText(text, context) {
    return Text(text,
        style: GoogleFonts.graduate(
          textStyle: TextStyle(
              color: Colors.red[200],
              fontWeight: FontWeight.normal,
              fontSize: ResponsiveLayout.isSmallScreen(context) ? 20 : 30),
        ));
  }

  Widget subTitleBoldText(text, context) {
    return Text(text,
        style: GoogleFonts.graduate(
          textStyle: TextStyle(
              color: Colors.red[200],
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveLayout.isSmallScreen(context) ? 20 : 30),
        ));
  }

  Widget smallText(text, context) {
    return Text(text,
        style: GoogleFonts.graduate(
          textStyle: TextStyle(
              color: Colors.red[200],
              fontWeight: FontWeight.normal,
              fontSize: ResponsiveLayout.isSmallScreen(context) ? 10 : 20),
        ));
  }
}
