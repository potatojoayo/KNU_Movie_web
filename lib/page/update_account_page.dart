import 'package:flutter/material.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/widget/add_movie_form.dart';
import 'package:knu_movie_web/widget/form_page_form_widget.dart';
import 'package:knu_movie_web/widget/my_button.dart';
import 'package:knu_movie_web/widget/texts.dart';
import 'package:knu_movie_web/widget/update_account_form.dart';
import 'package:knu_movie_web/widget/update_movie_form.dart';

class UpdateAccountPage extends StatelessWidget {
  const UpdateAccountPage(this.pageBloc, {Key key}) : super(key: key);
  final pageBloc;

  @override
  Widget build(BuildContext context) {
    return FormPageForm(
      pageBloc: pageBloc,
      mainText: "update",
      form: Flexible(
        child: SingleChildScrollView(
          //TODO
          child: UpdateMovieForm(pageBloc),
        ),
      ),
      icon: Icons.update,
      mainButton: MyButton(
          child: MyText().smallText('log out', context),
          context: context,
          onPressed: () {
            User.logout();

            pageBloc.goToLandingPage();
          }),
    );
  }
}
