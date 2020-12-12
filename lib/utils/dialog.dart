import 'package:flutter/material.dart';
import 'package:knu_movie_web/widget/texts.dart';

class MyDialog {
  static Future showMyDialog(title, actionWidgets, context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: MyText().smallText(title, context),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[],
          ),
        ),
        actions: <Widget>[...actionWidgets],
      ),
    );
  }
}
