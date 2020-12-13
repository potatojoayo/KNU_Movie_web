import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';

import 'package:knu_movie_web/model/log.dart';

import 'package:knu_movie_web/widget/texts.dart';

class AllLogListView extends StatelessWidget {
  final List<Log> logList;
  AllLogListView(this.logList);
  final api = API();

  @override
  Widget build(BuildContext context) {
    final lists = logList
        .map((e) => Column(
              children: [
                MyText().smallText(
                    "title : " +
                        e.originalTitle +
                        "   ||   rating : " +
                        e.rating.toString() +
                        "   ||   email : " +
                        e.email,
                    context),
                MyText().smallText("\n", context)
              ],
            ))
        .toList();

    return ListView(
      primary: false,
      children: [...lists],
    );
  }
}
