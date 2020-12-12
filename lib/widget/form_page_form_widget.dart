import 'package:flutter/material.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/widget/texts.dart';

import 'my_container.dart';

class FormPageForm extends StatelessWidget {
  FormPageForm(
      {Key key,
      @required this.pageBloc,
      @required this.mainText,
      @required this.icon,
      @required this.form,
      this.mainButton})
      : super(key: key);

  final pageBloc;
  final mainText;
  final form;
  final icon;
  final mainButton;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLarge = ResponsiveLayout.isLargeScreen(context);
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
                  ResponsiveLayout.isSmallScreen(context)
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Icon(icon,
                                  size: ResponsiveLayout.isSmallScreen(context)
                                      ? 100
                                      : 150,
                                  color: MyColor.red),
                              SizedBox(
                                  height:
                                      ResponsiveLayout.isSmallScreen(context)
                                          ? 20
                                          : 50),
                              MyText().subTitleText(mainText, context),
                              SizedBox(
                                  height:
                                      ResponsiveLayout.isSmallScreen(context)
                                          ? 20
                                          : 50),
                              mainButton
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
                        form,
                      ],
                    ),
                  ),
                ],
              ),
            ),
            context: context));
  }
}
