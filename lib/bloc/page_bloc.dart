import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/page/account_page.dart';
import 'package:knu_movie_web/page/landing_page.dart';
import 'package:knu_movie_web/page/login_page.dart';
import 'package:knu_movie_web/page/movie_page.dart';
import 'package:knu_movie_web/page/register_page.dart';
import 'package:knu_movie_web/page/search_page.dart';
import 'package:rxdart/rxdart.dart';

class PageBloc {
  final _page = PublishSubject<Widget>();

  Observable<Widget> get page => _page.stream;

  goToLandingPage() {
    _page.sink.add(LandingPage());
  }

  goToSearchPage(title, pageBloc, condition) {
    _page.sink.add(SearchPage(title, pageBloc, condition));
  }

  goTOLoginPage(pageBloc) {
    _page.sink.add(LoginPage(pageBloc));
  }

  goToSignupPage(pageBloc) {
    _page.sink.add(RegisterPage(pageBloc));
  }

  goToMoviePage(movieId) async {
    final api = API();
    final fmovie = api.crudMovie(mid: movieId.toString());

    final movie = await fmovie;

    var rating;
    if (User.email != null) {
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

  goToAccountPage(movieId) async {
    _page.sink.add(AccountPage());
  }

  dispose() {
    _page.close();
  }
}
