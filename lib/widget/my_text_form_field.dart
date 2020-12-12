import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';

class MyTextFormField extends StatefulWidget {
  final isPassword;
  final validator;
  final void Function(String) input;
  final void Function(String) onSubmit;
  final controller;
  final initValue;
  MyTextFormField(this.input,
      {this.validator,
      this.isPassword = false,
      this.onSubmit,
      this.controller,
      this.initValue});
  @override
  _MyTextFormFieldState createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initValue ?? null,
      controller: widget.controller,
      cursorColor: MyColor.red,
      onFieldSubmitted: widget.onSubmit,
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
        errorStyle: GoogleFonts.ubuntu(
            textStyle: TextStyle(
          fontSize: ResponsiveLayout.isSmallScreen(context) ? 7 : 13,
          color: MyColor.red,
        )),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.red, width: 2)),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.red, width: 1)),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.red, width: 2)),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyColor.red, width: 1)),
      ),
    );
  }
}
