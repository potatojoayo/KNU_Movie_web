import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  final img;
  CardItem(this.img);
  @override
  State<StatefulWidget> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Image.network(
          widget.img,
          fit: BoxFit.fill,
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5,
        margin: EdgeInsets.all(10));
  }
}
