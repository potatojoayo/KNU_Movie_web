import 'package:flutter/material.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/page/landing_page.dart';
import 'package:knu_movie_web/widget/movie_list_view.dart';

import 'api/API.dart';
import 'nav/nav_bar.dart';

MovieListView highRatingListView;
MovieListView hotInKoreaListView;
MovieListView classicListView;
MovieListView tvSeriesListView;
List<MovieListView> list = [
  highRatingListView,
  hotInKoreaListView,
  classicListView,
  tvSeriesListView
];

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
    final pageBloc = PageBloc();
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: StreamBuilder<Widget>(
            stream: null,
            builder: (context, snapshot) {
              return SafeArea(
                child: StreamBuilder<Widget>(
                    initialData: LandingPage(
                      listView: list,
                    ),
                    stream: pageBloc.page,
                    builder: (context, AsyncSnapshot<Widget> snapshot) {
                      return Column(
                        children: <Widget>[NavBar(), snapshot.data],
                      );
                    }),
              );
            },
          ),
        ),
      ),
    );
  }
}
