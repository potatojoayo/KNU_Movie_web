import 'package:flutter/material.dart';
import 'package:knu_movie_web/bloc/blocs.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/bloc/sub_page_bloc.dart';
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                MyButton(
                    child: MyText().smallText('MyMovies', context),
                    context: context,
                    onPressed: () {
                      Blocs.subPageBloc.goToUpdateAccountForm(pageBloc);
                    }),
                SizedBox(
                  height: 10,
                ),
                MyButton(
                    child: MyText().smallText('U-Profile', context),
                    context: context,
                    onPressed: () {
                      Blocs.subPageBloc.goToUpdateAccountForm(pageBloc);
                    }),
                SizedBox(
                  height: 10,
                ),
                MyButton(
                    child: MyText().smallText('AdminRe', context),
                    context: context,
                    onPressed: () {
                      Blocs.subPageBloc.goToUpdateAccountForm(pageBloc);
                    }),
                SizedBox(
                  height: 10,
                ),
                MyButton(
                    child: MyText().smallText('AdminUp', context),
                    context: context,
                    onPressed: () {
                      Blocs.subPageBloc.goToUpdateAccountForm(pageBloc);
                    }),
                SizedBox(
                  height: 10,
                ),
                MyButton(
                    child: MyText().smallText('AdminRa', context),
                    context: context,
                    onPressed: () {
                      Blocs.subPageBloc.goToUpdateAccountForm(pageBloc);
                    }),
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
                        return SingleChildScrollView(child: snapshot.data);
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
