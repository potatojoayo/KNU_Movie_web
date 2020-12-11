import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/bloc/menu_bloc.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/bloc/visiblilit_bloc.dart';
import 'package:knu_movie_web/main.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/model/item.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/widget/movie_search_condition.dart';
import '../utils/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/shadow.dart';

class NavBar extends StatefulWidget {
  static const Color menuIconColor = Color(0xFFEF9A9A);
  final PageBloc pageBloc;

  NavBar(this.pageBloc);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final redColor = Colors.red[200];

  final whiteColor = Colors.grey[300];

  final font = GoogleFonts.prompt();

  final api = API();

  final navLinks = [
    Icons.home_rounded,
    Icons.login_outlined,
    Icons.account_box
  ];
  VisibilityBloc visibilityBloc = VisibilityBloc();

  List<Item> naviMenu = <Item>[
    const Item(
        'Home',
        Icon(
          Icons.home_rounded,
          color: NavBar.menuIconColor,
        )),
    User.uid == null
        ? const Item(
            'SignIn',
            Icon(
              Icons.login_outlined,
              color: NavBar.menuIconColor,
            ))
        : null,
    const Item(
        'Account',
        Icon(
          Icons.account_box,
          color: NavBar.menuIconColor,
        )),
  ];

  List<Widget> navItem() {
    return navLinks.map((icon) {
      return Padding(
        padding: EdgeInsets.only(left: 10),
        child: RaisedButton(
          elevation: 5,
          color: redColor,
          onPressed: () {
            if (icon == Icons.home_rounded)
              widget.pageBloc.goToLandingPage();
            else if (icon == Icons.login_outlined)
              User.email != null
                  ? showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: Text('이미 로그인 하셨습니다'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[Text('이미 함')],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          )
                        ],
                      ),
                    )
                  : widget.pageBloc.goToLoginPage(widget.pageBloc);
            else if (icon == Icons.account_box) {
              User.email == null
                  ? showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: Text('로그인하세요'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[Text('안하면 안됨')],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              widget.pageBloc.goToLoginPage(pageBloc);
                            },
                            child: Text('Cancel'),
                          )
                        ],
                      ),
                    )
                  : pageBloc.goToAccountPage();
            }
          },
          child: Icon(icon, color: whiteColor),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Item selectedMenu = naviMenu[0];
    final menuBloc = MenuBloc();
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveLayout.isLargeScreen(context)
              ? MyPadding.mediaWidth(context)
              : MyPadding.normalHorizontal,
          vertical: ResponsiveLayout.isSmallScreen(context) ? 10 : 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.movie,
                      color: redColor,
                      size: ResponsiveLayout.isSmallScreen(context) ? 30 : 45,
                    ),
                    Text("KNU ",
                        style: GoogleFonts.prompt(
                          textStyle: TextStyle(
                              fontSize: ResponsiveLayout.isSmallScreen(context)
                                  ? 20
                                  : 30,
                              color: redColor,
                              shadows: [TextShadow.textShadow()]),
                        ))
                  ],
                ),
              ),
              borderRadius: BorderRadius.circular(10.0),
              onTap: () {
                widget.pageBloc.goToLandingPage();
              }),
          !ResponsiveLayout.isSmallScreen(context)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[SearchBar(pageBloc), ...navItem()],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SearchBar(pageBloc),
                    StreamBuilder<Item>(
                        stream: menuBloc.selectedMenu,
                        initialData: selectedMenu,
                        builder: (context, snapshot) {
                          return DropdownButton<Item>(
                              value: snapshot.data,
                              iconEnabledColor: redColor,
                              onChanged: (Item choosen) {
                                selectedMenu = choosen;
                                menuBloc.changeItem(choosen);
                                if (selectedMenu.name == 'Home')
                                  widget.pageBloc.goToLandingPage();
                                else if (selectedMenu.name == 'SignIn')
                                  User.email != null
                                      ? showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => AlertDialog(
                                            title: Text('이미 로그인 하셨습니다'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  Text('이미 함')
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Cancel'),
                                              )
                                            ],
                                          ),
                                        )
                                      : widget.pageBloc
                                          .goToLoginPage(widget.pageBloc);
                                else if (selectedMenu.name == 'Account') {
                                  // User.email == null
                                  //     ? showDialog(
                                  //         context: context,
                                  //         barrierDismissible: false,
                                  //         builder: (context) => AlertDialog(
                                  //           title: Text('로그인하세요'),
                                  //           content: SingleChildScrollView(
                                  //             child: ListBody(
                                  //               children: <Widget>[
                                  //                 Text('안하면 안됨')
                                  //               ],
                                  //             ),
                                  //           ),
                                  //           actions: <Widget>[
                                  //             TextButton(
                                  //               onPressed: () {
                                  //                 Navigator.of(context).pop();
                                  //                 widget.pageBloc
                                  //                     .goToLoginPage(pageBloc);
                                  //               },
                                  //               child: Text('Cancel'),
                                  //             )
                                  //           ],
                                  //         ),
                                  //       )
                                  pageBloc.goToAccountPage();
                                }
                              },
                              //
                              items: naviMenu.map((Item menu) {
                                return DropdownMenuItem<Item>(
                                    value: menu,
                                    child: Row(
                                      children: [
                                        menu.icon,
                                        SizedBox(width: 5),
                                        Text(menu.name,
                                            style: GoogleFonts.prompt(
                                                textStyle: TextStyle(
                                              fontSize: 17,
                                              color: redColor,
                                            )))
                                      ],
                                    ));
                              }).toList());
                        }),
                  ],
                )
        ],
      ),
    );
  }
}
