import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/main.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/model/conditionValue.dart';
import 'package:knu_movie_web/model/item.dart';
import 'package:knu_movie_web/page/account_page.dart';
import 'package:knu_movie_web/page/detail_search_page.dart';
import 'package:knu_movie_web/page/landing_page.dart';
import 'package:knu_movie_web/page/login_page.dart';
import 'package:knu_movie_web/page/movie_page.dart';
import 'package:knu_movie_web/page/register_page.dart';
import 'package:knu_movie_web/page/search_page.dart';
import 'package:knu_movie_web/page/update_movie_page.dart';
import 'package:rxdart/rxdart.dart';

import 'blocs.dart';

class PageBloc {
  final _page = PublishSubject<Widget>();

  Stream<Widget> get page => _page.stream;

  goToLandingPage() async {
    Blocs.menuBloc.changeItem(Item.conditionMenu[0]);
    final api = API();
    if (User.email != null)
      User.myLogs = await api.ratingLog(email: User.email);
    _page.sink.add(LandingPage());
  }

  goToUpdateMoviePage(pageBloc) {
    Blocs.menuBloc.changeItem(Item.conditionMenu[0]);

    _page.sink.add(UpdateMoviePage(pageBloc));
  }

  goToSearchPage(pageBloc, List<ConditionValue> conditionValue) {
    Blocs.menuBloc.changeItem(Item.conditionMenu[0]);

    _page.sink.add(SearchPage(pageBloc, conditionValue));
  }

  // goToUserLogPage() async {
  //   Blocs.menuBloc.changeItem(Item.conditionMenu[0]);
  //   final api = API();
  //   final logList = await api.ratingLog(email: "knu@knu.ac.kr");

  goToLoginPage(pageBloc) async {
    Blocs.menuBloc.changeItem(Item.conditionMenu[0]);

    _page.sink.add(LoginPage(pageBloc));
  }

  goToDetailSearchPage(pageBloc) {
    _page.sink.add(DetailSearchPage(pageBloc));
  }

  goToSignupPage(pageBloc) {
    Blocs.menuBloc.changeItem(Item.conditionMenu[0]);

    _page.sink.add(RegisterPage(pageBloc));
  }

  goToMoviePage(movieId) async {
    Blocs.menuBloc.changeItem(Item.conditionMenu[0]);

    final api = API();
    final fmovie = api.crudMovie(mid: movieId.toString());

    final movie = await fmovie;

    double rating = 0;
    if (User.uid != null) {
      final ratingLog =
          await api.aMovieRating(mid: movie.movieId, uid: User.uid);
      if (ratingLog.rating != 0)
        rating = ratingLog.rating / 2;
      else
        rating = 0;
    } else
      rating = 0;

    _page.sink.add(MoviePage(movie, rating));
  }

  goToAccountPage() {
    Blocs.menuBloc.changeItem(Item.conditionMenu[0]);

    _page.sink.add(AccountPage(pageBloc));
  }

  dispose() {
    _page.close();
  }
}
