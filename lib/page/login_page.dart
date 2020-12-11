import 'package:flutter/material.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/main.dart';
import 'package:knu_movie_web/widget/form_page_form_widget.dart';
import 'package:knu_movie_web/widget/login_form.dart';
import 'package:knu_movie_web/widget/texts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(this.pageBloc, {Key key}) : super(key: key);
  final pageBloc;

  @override
  Widget build(BuildContext context) {
    return FormPageForm(
      pageBloc: pageBloc,
      mainText: "login",
      form: LoginForm(pageBloc),
      icon: Icons.login,
      mainButton: signupButton(context),
    );
  }
}

RaisedButton signupButton(BuildContext context) {
  return RaisedButton(
    child: MyText().smallTextGrey("signup", context),
    disabledColor: MyColor.red,
    color: MyColor.red,
    onPressed: () {
      pageBloc.goToSignupPage(pageBloc);
    },
  );
}
