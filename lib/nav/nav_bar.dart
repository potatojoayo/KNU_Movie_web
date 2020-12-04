import 'package:flutter/material.dart';
import 'package:knu_movie_web/model/item.dart';
import 'package:knu_movie_web/utils/padding.dart';
import '../utils/responsive_layout.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/shadow.dart';

class NavBar extends StatefulWidget {
  static const Color menuIconColor = Color(0xFFEF9A9A);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final redColor = Colors.red[200];

  final whiteColor = Colors.grey[300];

  final font = GoogleFonts.prompt();

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
            if (icon == Icons.home_rounded) {}
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
                                fontSize:
                                    ResponsiveLayout.isSmallScreen(context)
                                        ? 20
                                        : 30,
                                color: redColor,
                                shadows: [TextShadow.textShadow()]),
                          ))
                    ],
                  ),
                ),
                borderRadius: BorderRadius.circular(10.0),
                onTap: () {}),
            if (!ResponsiveLayout.isSmallScreen(context))
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[...navItem()],
              )
            else
              DropdownButton<Item>(
                  value: selectedMenu,
                  iconEnabledColor: redColor,
                  onChanged: (Item choosen) {
                    selectedMenu = choosen;
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
        ));
  }
}
