import 'package:flutter/material.dart';
import 'package:knu_movie_web/utils/smooth_scroll_ctr.dart';

class SmoothScroll extends StatelessWidget {
  final ScrollController controller = ScrollController();
  SmoothScroll(this.child);
  final child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SmoothScroll Example"),
      ),
      body: SmoothScrollWeb(
        child: child,
        controller: controller,
      ),
    );
  }
}
