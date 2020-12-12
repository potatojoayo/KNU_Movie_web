import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton(
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
        color: buttonColor,
        onPressed: () {
          onPressed();
        },
        child: child);
  }
}
