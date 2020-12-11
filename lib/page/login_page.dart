import 'package:flutter/material.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/main.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/widget/my_container.dart';
import 'package:knu_movie_web/widget/login_form.dart';
import 'package:knu_movie_web/widget/texts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(this.pageBloc, {Key key}) : super(key: key);
  final pageBloc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isLarge = ResponsiveLayout.isLargeScreen(context);
    // bool isMedium = ResponsiveLayout.isMediumScreen(context);

    return Padding(
        padding: EdgeInsets.only(
            left: isLarge
                ? MyPadding.mediaWidth(context)
                : MyPadding.normalHorizontal,
            right: isLarge
                ? MyPadding.mediaWidth(context)
                : MyPadding.normalHorizontal,
            bottom: MediaQuery.of(context).size.height / 10),
        child: MyContainer(
            width: size.width,
            height: size.height / 1.2,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveLayout.isLargeScreen(context)
                      ? size.width / 10
                      : size.width / 15),
              child: Row(
                children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.login,
                            size: ResponsiveLayout.isSmallScreen(context)
                                ? 100
                                : 150,
                            color: MyColor.red),
                        SizedBox(
                            height: ResponsiveLayout.isSmallScreen(context)
                                ? 20
                                : 50),
                        MyText().subTitleText("signin", context),
                        SizedBox(
                            height: ResponsiveLayout.isSmallScreen(context)
                                ? 20
                                : 50),
                        signupButton(context)
                      ]),
                  SizedBox(
                    width: ResponsiveLayout.isLargeScreen(context)
                        ? size.width / 10
                        : size.width / 15,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginForm(pageBloc),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            context: context));
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
