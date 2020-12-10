import 'package:flutter/material.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/page/landing_page.dart';

import 'nav/nav_bar.dart';

PageBloc pageBloc;

void main() async {
  pageBloc = PageBloc();

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
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: StreamBuilder<Widget>(
            stream: null,
            builder: (context, snapshot) {
              return SafeArea(
                child: StreamBuilder<Widget>(
                    initialData: LandingPage(),
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
