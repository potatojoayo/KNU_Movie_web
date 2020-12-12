import 'package:flutter/material.dart';
import 'package:knu_movie_web/color/color.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {Key key,
      @required this.child,
      @required this.context,
      @required this.onPressed,
      this.buttonColor})
      : super(key: key);

  final child;
  final void Function() onPressed;
  final BuildContext context;
  final buttonColor;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        disabledColor: buttonColor ?? MyColor.grey,
        color: buttonColor ?? MyColor.grey,
        onPressed: () {
          onPressed();
        },
        child: child);
  }
}
