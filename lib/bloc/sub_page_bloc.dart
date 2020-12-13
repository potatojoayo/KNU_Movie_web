import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/page/landing_page.dart';
import 'package:knu_movie_web/widget/add_movie_form.dart';
import 'package:knu_movie_web/widget/all_log_list_view.dart';
import 'package:knu_movie_web/widget/update_account_form.dart';
import 'package:knu_movie_web/widget/update_movie_form.dart';
import 'package:knu_movie_web/widget/user_log_list_view.dart';
import 'package:rxdart/rxdart.dart';

class SubPageBloc {
  final _subPage = PublishSubject<Widget>();

  Stream<Widget> get subPage => _subPage.stream;

  goToUpdateAccountForm(pageBloc) {
    _subPage.sink
        .add(SingleChildScrollView(child: UpdateAccountForm(pageBloc)));
  }

  goToAddMovieForm(pageBloc) {
    _subPage.sink.add(SingleChildScrollView(child: AddMovieForm(pageBloc)));
  }

  goToAllLogListView(pageBloc) async {
    final api = API();
    final myMovieList = await api.ratingLog();
    _subPage.sink.add(AllLogListView(myMovieList));
  }

  goToUserLogForm() async {
    final api = API();
    final myMovieList = await api.ratingLog(email: User.email);
    _subPage.sink.add(LogListView(myMovieList));
  }

  goToUpdateMovieForm(pageBloc) {
    _subPage.sink.add(UpdateMovieForm(pageBloc));
  }

  dispose() {
    _subPage.close();
  }
}
