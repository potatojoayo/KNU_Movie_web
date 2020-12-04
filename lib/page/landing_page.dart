import 'package:flutter/material.dart';
import 'package:knu_movie_web/widget/my_container.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/widget/movie_list_view.dart';
import 'package:knu_movie_web/widget/texts.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key, this.listView}) : super(key: key);
  final List<MovieListView> listView;
  @override
  Widget build(BuildContext context) {
    final myText = MyText();
    final homeContainer = MyContainer();
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
            homeContainer.homeContainer(
                size.width, size.height / 4, listView[0], context),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              myText.subTitleText("Hot in Korea  ", context)
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(
                size.width, size.height / 4, listView[1], context),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              myText.subTitleText("Classics  ", context)
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(
                size.width, size.height / 4, listView[2], context),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              myText.subTitleText("TvSeries  ", context)
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(
                size.width, size.height / 4, listView[3], context),
            verticalSizedBox(),
            verticalSizedBox(),
            verticalSizedBox(),
          ],
        ));
  }
}
