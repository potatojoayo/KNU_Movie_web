import 'package:flutter/material.dart';

class MyBox extends StatelessWidget {
  const MyBox({
    Key key,
    @required this.width,
    @required this.child,
    @required this.context,
  }) : super(key: key);

  final width;
  final child;
  final context;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: child,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(
            Radius.circular(40),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500],
              offset: Offset(4.0, 4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 15.0,
              spreadRadius: 1.0,
            ),
          ],
        ));
  }
}
