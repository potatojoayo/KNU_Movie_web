import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final redColor = Colors.red[200];
    return Container(
      width: 200,
      height: 30,
      child: TextField(
        decoration: InputDecoration(
            icon: Icon(
              Icons.clear,
              color: redColor,
            ),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: redColor))),
      ),
    );
  }
}
