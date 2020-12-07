import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/main.dart';
import 'package:knu_movie_web/widget/my_container.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/widget/movie_list_view.dart';
import 'package:knu_movie_web/widget/texts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final api = API();
    var highRatingListView = MovieListView(api.highRatings(1), pageBloc);
    var hotInKoreaListView = MovieListView(api.hotInKorea(1), pageBloc);
    var classicListView = MovieListView(api.classics(1), pageBloc);
    var tvSeriesListView = MovieListView(api.tvSeries(1), pageBloc);
    final listView = [
      highRatingListView,
      hotInKoreaListView,
      classicListView,
      tvSeriesListView
    ];
    final myText = MyText();
    bool isLarge = ResponsiveLayout.isLargeScreen(context);
    Size size = MediaQuery.of(context).size;
    Widget verticalSizedBox() {
      return SizedBox(height: size.height / 50);
    }

    return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isLarge
              ? MyPadding.mediaWidth(context)
              : MyPadding.normalHorizontal,
        ),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              myText.subTitleText("High ratings  ", context)
            ]),
            verticalSizedBox(),
            MyContainer(
                width: size.width,
                height: size.height / 4,
                child: listView[0],
                context: context),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              myText.subTitleText("Hot in Korea  ", context)
            ]),
            verticalSizedBox(),
            MyContainer(
                width: size.width,
                height: size.height / 4,
                child: listView[1],
                context: context),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              myText.subTitleText("Classics  ", context)
            ]),
            verticalSizedBox(),
            MyContainer(
                width: size.width,
                height: size.height / 4,
                child: listView[2],
                context: context),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              myText.subTitleText("TvSeries  ", context)
            ]),
            verticalSizedBox(),
            MyContainer(
                width: size.width,
                height: size.height / 4,
                child: listView[3],
                context: context),
            verticalSizedBox(),
            verticalSizedBox(),
            verticalSizedBox(),
          ],
        ));
  }
}
