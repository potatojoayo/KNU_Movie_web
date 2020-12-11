import 'package:flutter/material.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';

import 'my_container.dart';

<<<<<<< HEAD
class SkeletonWidget extends StatelessWidget {
  SkeletonWidget({Key key, @required this.child}) : super(key: key);
=======
class SkeltonWidget extends StatelessWidget {
  SkeltonWidget({Key key, @required this.child}) : super(key: key);
>>>>>>> 9d0f03d93f9288ede66846b7829168fd96e5bb4f

  final child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLarge = ResponsiveLayout.isLargeScreen(context);
    return Padding(
        padding: EdgeInsets.only(
            left: isLarge
                ? MyPadding.mediaWidth(context)
                : MyPadding.normalHorizontal,
            right: isLarge
                ? MyPadding.mediaWidth(context)
                : MyPadding.normalHorizontal,
            bottom: MediaQuery.of(context).size.height / 10),
        child: MyContainer(
            width: size.width,
            height: size.height / 1.2,
            child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveLayout.isLargeScreen(context)
                        ? size.width / 10
                        : size.width / 15),
                child: child),
            context: context));
  }
}
