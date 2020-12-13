import 'package:flutter/material.dart';
import 'package:knu_movie_web/widget/form_page_form_widget.dart';
import 'package:knu_movie_web/widget/update_movie_form.dart';

class UpdateMoviePage extends StatelessWidget {
  const UpdateMoviePage(this.pageBloc, {Key key}) : super(key: key);
  final pageBloc;

  @override
  Widget build(BuildContext context) {
    return FormPageForm(
        pageBloc: pageBloc,
        mainText: "update movie",
        form: Flexible(
          child: SingleChildScrollView(
            child: UpdateMovieForm(pageBloc),
          ),
        ),
        icon: Icons.movie_creation_rounded,
        mainButton: Container());
  }
}
