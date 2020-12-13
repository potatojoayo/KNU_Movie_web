import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/User.dart';

import 'package:knu_movie_web/model/log.dart';
import 'package:knu_movie_web/page/movie_page.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';

import 'package:knu_movie_web/widget/texts.dart';

class UserLogPage extends StatelessWidget {
  final List<Log> logList;
  UserLogPage(this.logList);
  final api = API();

  @override
  Widget build(BuildContext context) {
    final lists = logList
        .map((e) => Card(
              color: MyColor.grey,
              elevation: 0,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                    width: 150,
                    height: 225,
                    child: MyPhotoCard(image: e.postImage)),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText().smallText(
                        e.originalTitle + " (" + e.datePart.toString() + ")",
                        context),
                    SizedBox(
                      height: 15,
                    ),
                    RatingBar.builder(
                        initialRating: (e.rating / 2).toDouble(),
                        minRating: 0,
                        itemSize:
                            ResponsiveLayout.isSmallScreen(context) ? 15 : 30,
                        allowHalfRating: true,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        updateOnDrag: true,
                        unratedColor: Colors.amber.withAlpha(50),
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) =>
                            Icon(Icons.star, color: Colors.amber),
                        onRatingUpdate: (rating) {
                          api.rating(User.uid.toString(), e.movieId.toString(),
                              (rating * 2).toString());
                        }),
                  ],
                ))
              ]),
            ))
        .toList();

    return ListView(
      primary: false,
      children: [...lists],
    );
  }
}
