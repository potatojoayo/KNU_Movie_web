import 'package:flutter/material.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/page/account_page.dart';
import 'package:knu_movie_web/page/landing_page.dart';

import 'api/API.dart';
import 'model/Lists.dart';
import 'model/actor.dart';
import 'model/director.dart';
import 'model/genre.dart';
import 'nav/nav_bar.dart';

PageBloc pageBloc;

void main() async {
  pageBloc = PageBloc();
  final api = API();

  final directors = await api.selectDirector();
  for (Director d in directors) {
    Lists.directors.add(d.name);
  }
  final actors = await api.selectActor();
  for (Actor a in actors) {
    Lists.actors.add(a.name);
  }
  final genres = await api.selectGenre();
  for (Genre g in genres) {
    Lists.genres.add(g.genre);
  }

  print(Lists.genres[0]);

  runApp(KnuMovieWeb());
}

class KnuMovieWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Knu Movie Web',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          buttonColor: Color(0xFFEEEEE),
          primarySwatch: Colors.grey,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: StreamBuilder<Widget>(
            stream: null,
            builder: (context, snapshot) {
              return SafeArea(
                child: StreamBuilder<Widget>(
                    initialData: AccountPage(pageBloc),
                    stream: pageBloc.page,
                    builder: (context, AsyncSnapshot<Widget> snapshot) {
                      return Column(
                        children: <Widget>[NavBar(pageBloc), snapshot.data],
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
