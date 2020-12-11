import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';

class MyTextFormField extends StatefulWidget {
  final isPassword;
  final validator;
  final void Function(String) input;
  MyTextFormField(this.input, {this.validator, this.isPassword = false});
  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: MyColor.red,
      validator: widget.validator,
      cursorWidth: 3,
      obscureText: widget.isPassword,
      style: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          fontSize: ResponsiveLayout.isSmallScreen(context) ? 13 : 20,
          color: MyColor.red,
        ),
      ),
      onSaved: widget.input,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.red, width: 2)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.red, width: 1)),
      ),
    );
  }
}
