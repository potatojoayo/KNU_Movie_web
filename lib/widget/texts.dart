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

  Widget smallText(text, context, {fontSize}) {
    return Text(text,
        style: GoogleFonts.graduate(
          textStyle: TextStyle(
              color: Colors.red[200],
              fontWeight: FontWeight.normal,
              fontSize: fontSize == null
                  ? (ResponsiveLayout.isSmallScreen(context) ? 13 : 20)
                  : fontSize),
        ));
  }

  Widget smallTextGrey(text, context, {fontSize}) {
    return Text(text,
        style: GoogleFonts.graduate(
          textStyle: TextStyle(
              color: Colors.grey[200],
              fontWeight: FontWeight.normal,
              fontSize: fontSize == null
                  ? (ResponsiveLayout.isSmallScreen(context) ? 13 : 20)
                  : fontSize),
        ));
  }

  Widget smallTextSelectColor(text, context, color, {fontSize}) {
    return Text(text,
        style: GoogleFonts.graduate(
          textStyle: TextStyle(
              color: color,
              fontWeight: FontWeight.normal,
              fontSize: fontSize == null
                  ? (ResponsiveLayout.isSmallScreen(context) ? 13 : 20)
                  : fontSize),
        ));
  }
}
