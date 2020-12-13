import 'package:flutter/material.dart';
import 'package:knu_movie_web/bloc/blocs.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/bloc/sub_page_bloc.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/widget/my_button.dart';
import 'package:knu_movie_web/widget/page_skeleton.dart';
import 'package:knu_movie_web/widget/texts.dart';

class AccountPage extends StatelessWidget {
  AccountPage(this.pageBloc, {Key key}) : super(key: key);
  final PageBloc pageBloc;
  final SubPageBloc subPageBloc = SubPageBloc();

  @override
  Widget build(BuildContext context) {
    return SkeletonWidget(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          //AccountNavBar
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                MyButton(
                    buttonColor: MyColor.red,
                    child: MyText().subTitleTextGrey('My Movies', context),
                    context: context,
                    onPressed: () {
                      Blocs.subPageBloc.goToUserLogForm();
                    }),
                SizedBox(
                  height: 10,
                ),
                MyButton(
                    buttonColor: MyColor.red,
                    child: MyText().subTitleTextGrey('Update Account', context),
                    context: context,
                    onPressed: () {
                      Blocs.subPageBloc.goToUpdateAccountForm(pageBloc);
                    }),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: User.isAdmin != null ? User.isAdmin : false,
                  child: MyButton(
                      buttonColor: MyColor.red,
                      child: MyText().subTitleTextGrey('Add Movie', context),
                      context: context,
                      onPressed: () {
                        Blocs.subPageBloc.goToAddMovieForm(pageBloc);
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: User.isAdmin != null ? User.isAdmin : false,
                  child: MyButton(
                      buttonColor: MyColor.red,
                      child: MyText().subTitleTextGrey('Rating logs', context),
                      context: context,
                      onPressed: () {
                        Blocs.subPageBloc.goToAllLogListView(pageBloc);
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                MyButton(
                    buttonColor: MyColor.red,
                    child: MyText().subTitleTextGrey('Log out', context),
                    context: context,
                    onPressed: () {
                      User.logout();
                      pageBloc.goToLandingPage();
                    }),
                SizedBox(height: 50),
              ],
            ),
          ),
          //AccountContents
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: StreamBuilder<Widget>(
                      stream: Blocs.subPageBloc.subPage,
                      initialData: Container(),
                      builder: (context, snapshot) {
                        return snapshot.data;
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
