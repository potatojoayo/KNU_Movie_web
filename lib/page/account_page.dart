import 'package:flutter/material.dart';
import 'package:knu_movie_web/model/item.dart';
import 'package:knu_movie_web/widget/page_skeleton.dart';

class AccountPage extends StatelessWidget {
  List<Item> accountButton = <Item>[];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SkeletonWidget(
        child: Column(
          children: <Widget>[
            //AccountNavBar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[ListView()],
            ),
            //AccountContents
            Row(
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }
}
