import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  static TextEditingController submit = TextEditingController();
  //submit
  //textFont
  final redColor = Colors.red[200];

  InputText(TextEditingController submitText) {
    submit = submitText;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 35,
      child: TextField(
        controller: submit,
        decoration: InputDecoration(
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: redColor)),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: redColor))),
      ),
    );
  }
}
