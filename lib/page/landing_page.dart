import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/main.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/model/movie.dart';
import 'package:knu_movie_web/widget/my_container.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/widget/movie_list_view.dart';
import 'package:knu_movie_web/widget/texts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool isMore = false;
    final api = API();
    var highRatingListView = MovieListView(
        api.highRatings(User.uid != null ? User.uid : 1), pageBloc);
    var hotInKoreaListView = MovieListView(
        api.hotInKorea(User.uid != null ? User.uid : 1), pageBloc);
    var classicListView =
        MovieListView(api.classics(User.uid != null ? User.uid : 1), pageBloc);
    var tvSeriesListView =
        MovieListView(api.tvSeries(User.uid != null ? User.uid : 1), pageBloc);

    var listView = [
      highRatingListView,
      hotInKoreaListView,
      classicListView,
      tvSeriesListView
    ];

    if (User.myLogs != null) {
      if (User.myLogs.isNotEmpty) {
        var recGenreListView =
            MovieListView(api.recommendGenre(User.uid), pageBloc);
        var recActorListView =
            MovieListView(api.recommendActor(User.uid), pageBloc);
        var recDirectorListView =
            MovieListView(api.recommendDirector(User.uid), pageBloc);

        listView.insert(0, recDirectorListView);
        listView.insert(0, recActorListView);
        listView.insert(0, recGenreListView);

        isMore = true;
      }
    }

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
              myText.subTitleText(
                  isMore ? "genres you like  " : "High ratings  ", context)
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
              myText.subTitleText(
                  isMore ? "actors you like  " : "Hot in Korea  ", context)
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
              myText.subTitleText(
                  isMore ? "directors you like  " : "Classics  ", context)
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
              myText.subTitleText("high ratings  ", context)
            ]),
            verticalSizedBox(),
            MyContainer(
                width: size.width,
                height: size.height / 4,
                child: listView[3],
                context: context),
            verticalSizedBox(),
            if (isMore)
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  width: 10,
                ),
                myText.subTitleText("hot in korea  ", context)
              ]),
            verticalSizedBox(),
            if (isMore)
              MyContainer(
                  width: size.width,
                  height: size.height / 4,
                  child: listView[4],
                  context: context),
            verticalSizedBox(),
            if (isMore)
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  width: 10,
                ),
                myText.subTitleText("classics  ", context)
              ]),
            verticalSizedBox(),
            if (isMore)
              MyContainer(
                  width: size.width,
                  height: size.height / 4,
                  child: listView[5],
                  context: context),
            verticalSizedBox(),
            if (isMore)
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  width: 10,
                ),
                myText.subTitleText("TvSeries  ", context)
              ]),
            verticalSizedBox(),
            if (isMore)
              MyContainer(
                  width: size.width,
                  height: size.height / 4,
                  child: listView[6],
                  context: context),
            verticalSizedBox(),
            verticalSizedBox(),
            verticalSizedBox(),
          ],
        ));
  }
}
