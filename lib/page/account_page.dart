import 'package:flutter/material.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/model/item.dart';
import 'package:knu_movie_web/nav/nav_bar.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/widget/page_skeleton.dart';

class AccountPage extends StatelessWidget {
  var redColor = Colors.red[200];
  final accountButton = [
    //mymovieList
    Icons.movie_filter,
    //mypersonalInfo,회원 정보 수정(비밀번호), 회원 탈퇴
    Icons.person,
    //RegisterByAdmin, 영상물 등록
    Icons.my_library_add,
    //UpdateMovie, 영상물 수정
    Icons.update,
    //AllratedInfoConfirm, 모든 평가내역 확인
    Icons.rate_review
  ];

//LargeSize
  List<Widget> subNavi(context) {
    final isLarge = ResponsiveLayout.isLargeScreen(context);
    final size = MediaQuery.of(context).size;

    return accountBtn.map((icon) {
      return Padding(
        padding:
            EdgeInsets.only(top: isLarge ? size.height / 10 : size.height / 20),
        child: RaisedButton(
          color: Colors.white,
          elevation: 5,
          onPressed: () {
            if (icon == Icons.my_library_add) {}
          },
        ),
      );
    }).toList();
  }

//SmallerSize
  List<Item> accountBtn = <Item>[
    Item(
      'My Movie List',
      Icon(
        Icons.movie_filter,
        color: NavBar.menuIconColor,
      ),
    ),
    Item(
      'My Personal Info',
      Icon(
        Icons.person,
        color: NavBar.menuIconColor,
      ),
    ),
    Item(
      'Register By Admin',
      Icon(
        Icons.my_library_add,
        color: NavBar.menuIconColor,
      ),
    ),
    Item(
      'Update Movie',
      Icon(
        Icons.update,
        color: NavBar.menuIconColor,
      ),
    ),
    Item(
      'AllratedInfoConfirm',
      Icon(
        Icons.rate_review,
        color: NavBar.menuIconColor,
      ),
    ),
  ];

  AccountPage(this.pageBloc, {Key key}) : super(key: key);
  final PageBloc pageBloc;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: SkeletonWidget(
        child: Row(
          children: <Widget>[
            //AccountNavBar
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              width: ResponsiveLayout.isLargeScreen(context)
                  ? size.width / 8
                  : size.width / 8,
              height: ResponsiveLayout.isLargeScreen(context)
                  ? size.height / 1
                  : size.height / 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  ...subNavi(context)
                ],
              ),
            ),
            //AccountContents
            Container(
              width: ResponsiveLayout.isLargeScreen(context)
                  ? size.width / 1.65
                  : size.width / 1.65,
              height: size.height / 1,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Row(
                children: <Widget>[],
              ),
            )
          ],
        ),
      ),
    );
  }
}
