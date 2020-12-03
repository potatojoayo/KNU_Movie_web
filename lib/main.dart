import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/utils/shadow.dart';

import 'api/API.dart';
import 'utils/smooth_scroll_ctr.dart';
import 'widget/nav_bar.dart';

MovieListView highRatingListView;
MovieListView hotInKoreaListView;
MovieListView classicListView;
MovieListView tvSeriesListView;
ScrollController controller;

void main() async {
  final api = API();
  highRatingListView = MovieListView(api.highRatings(1));
  hotInKoreaListView = MovieListView(api.hotInKorea(1));
  classicListView = MovieListView(api.classics(1));
  tvSeriesListView = MovieListView(api.tvSeries(1));
  runApp(KnuMovieWeb());
}

class KnuMovieWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Knu Movie Web',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    controller = ScrollController();
    return Container(
        child: Scaffold(
            backgroundColor: Colors.grey[300],
            body: SingleChildScrollView(
                child: StreamBuilder<Object>(
                    stream: null,
                    builder: (context, snapshot) {
                      return SafeArea(
                          child:
                              Column(children: <Widget>[NavBar(), HomeBody()]));
                    }))));
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final homeText = HomeText();
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
              homeText.homeText("High ratings  ", context)
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(
                size.width, size.height / 4, highRatingListView, context),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              homeText.homeText("Hot in Korea  ", context)
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(
                size.width, size.height / 4, hotInKoreaListView, context),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              homeText.homeText("Classics  ", context)
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(
                size.width, size.height / 4, classicListView, context),
            verticalSizedBox(),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                width: 10,
              ),
              homeText.homeText("TvSeries  ", context)
            ]),
            verticalSizedBox(),
            homeContainer.homeContainer(
                size.width, size.height / 4, tvSeriesListView, context),
            verticalSizedBox(),
            verticalSizedBox(),
            verticalSizedBox(),
          ],
        ));
  }
}

class MyContainer {
  Widget homeContainer(width, height, futureBuilder, context) {
    return Container(
        child: FractionallySizedBox(
            heightFactor: ResponsiveLayout.isSmallScreen(context) ? 0.8 : 0.9,
            widthFactor: ResponsiveLayout.isSmallScreen(context) ? 0.85 : 0.95,
            child: futureBuilder),
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

class MovieListView extends StatelessWidget {
  final list;
  const MovieListView(this.list, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: list,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return Container();
        else
          return ListView.builder(
              itemCount: snapshot.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String image = snapshot.data[index].postImage;
                return Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: InkWell(
                    onHover: (value) {},
                    onTap: () {},
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5.0,
                      semanticContainer: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Image.network(
                        image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                );
              });
        ;
      },
    );
  }
}

class HomeText {
  Widget homeText(text, context) {
    return Text(text,
        style: GoogleFonts.prompt(
          textStyle: TextStyle(
              color: Colors.red[200],
              fontWeight: FontWeight.w400,
              shadows: [TextShadow.textShadow()],
              fontSize: ResponsiveLayout.isSmallScreen(context) ? 20 : 27),
        ));
  }
}
