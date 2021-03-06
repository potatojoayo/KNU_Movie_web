import 'package:flutter/material.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';

class MyContainer extends StatelessWidget {
  const MyContainer({
    Key key,
    @required this.width,
    @required this.height,
    @required this.child,
    @required this.context,
  }) : super(key: key);

  final width;
  final height;
  final child;
  final context;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FractionallySizedBox(
            heightFactor: ResponsiveLayout.isSmallScreen(context) ? 0.8 : 0.9,
            widthFactor: ResponsiveLayout.isSmallScreen(context) ? 0.85 : 0.95,
            child: child),
        width: width,
        height: height,
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
