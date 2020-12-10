import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/model/item.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/widget/inputText.dart';
import '../utils/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/shadow.dart';

class NavBar extends StatefulWidget {
  static const Color menuIconColor = Color(0xFFEF9A9A);
  final PageBloc bloc;

  NavBar(this.bloc);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final redColor = Colors.red[200];

  final whiteColor = Colors.grey[300];

  final font = GoogleFonts.prompt();

  final api = API();

  var isSearchOpen = false;

  final navLinks = [
    Icons.home_rounded,
    Icons.login_outlined,
    Icons.account_box
  ];

  List<Item> naviMenu = <Item>[
    const Item(
        'Home',
        Icon(
          Icons.home_rounded,
          color: NavBar.menuIconColor,
        )),
    const Item(
        'SignIn',
        Icon(
          Icons.login_outlined,
          color: NavBar.menuIconColor,
        )),
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
            if (icon == Icons.home_rounded) widget.bloc.goToLandingPage();
          },
          child: Icon(icon, color: whiteColor),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Item selectedMenu = naviMenu[0];
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
                widget.bloc.goToLandingPage();
              }),
          if (!ResponsiveLayout.isSmallScreen(context))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                AnimatedOpacity(
                    opacity: isSearchOpen ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: InputText()),
                InkWell(
                    borderRadius: BorderRadius.circular(10.0),
                    onTap: () {
                      setState(() {
                        isSearchOpen = !isSearchOpen;
                      });
                    },
                    child: Icon(
                      Icons.search_rounded,
                      color: redColor,
                      size: 30,
                    )),
                SizedBox(
                  width: 10,
                ),
                ...navItem()
              ],
            )
          else
            DropdownButton<Item>(
                value: selectedMenu,
                iconEnabledColor: redColor,
                onChanged: (Item choosen) {
                  selectedMenu = choosen;
                  if (selectedMenu.name == 'Home')
                    widget.bloc.goToLandingPage();
                },
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
                }).toList())
        ],
      ),
    );
  }
}
