import 'package:flutter/material.dart';
import 'package:knu_movie_web/page/landing_page.dart';
import 'package:rxdart/rxdart.dart';

class PageBloc {
  final _page = PublishSubject<Widget>();

  Observable<Widget> get page => _page.stream;

  goToLandingPage(list) {
    _page.sink.add(LandingPage(
      listView: list,
    ));
  }

  dispose() {
    _page.close();
  }
}
