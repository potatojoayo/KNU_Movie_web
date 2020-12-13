import 'package:flutter/material.dart';
import 'package:knu_movie_web/page/landing_page.dart';
import 'package:knu_movie_web/widget/update_account_form.dart';
import 'package:rxdart/rxdart.dart';

class SubPageBloc {
  final _subPage = PublishSubject<Widget>();

  Stream<Widget> get subPage => _subPage.stream;

  goToUpdateAccountForm(pageBloc) {
    _subPage.sink.add(UpdateAccountForm(pageBloc));
  }

  goToLandingPage() {
    _subPage.sink.add(LandingPage());
  }

  dispose() {
    _subPage.close();
  }
}
