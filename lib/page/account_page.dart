import 'dart:html';

import 'package:flutter/material.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/model/item.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/widget/page_skeleton.dart';

class AccountPage extends StatelessWidget {
  List<Item> accountButton = <Item>[];

  AccountPage(this.pageBloc, {Key key}) : super(key: key);
  final PageBloc pageBloc;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: SkeletonWidget(
        child: Row(
          children: <Widget>[
            //AccountNavBar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                width: ResponsiveLayout.isLargeScreen(context)
                    ? size.width / 5
                    : size.width / 5,
                height: ResponsiveLayout.isLargeScreen(context)
                    ? size.height / 1
                    : size.height / 1,
                child: ListView(children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[Text('data')],
                  ),
                ]),
              ),
            ),
            //AccountContents
            Container(
              width: ResponsiveLayout.isLargeScreen(context)
                  ? size.width / 3
                  : size.width / 2,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Row(
                children: <Widget>[],
              ),
            )
          ],
        ),
      ),
    );
  }
}
