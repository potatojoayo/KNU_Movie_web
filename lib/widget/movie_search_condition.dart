import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knu_movie_web/bloc/menu_bloc.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/bloc/visiblilit_bloc.dart';
import 'package:knu_movie_web/main.dart';
import 'package:knu_movie_web/model/item.dart';
import 'package:knu_movie_web/nav/nav_bar.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';

class SearchBar extends StatefulWidget {
  final PageBloc bloc;
  SearchBar(this.bloc);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  List<Item> conditionMenu = <Item>[
    const Item(
        'Title',
        Icon(
          Icons.search,
          color: NavBar.menuIconColor,
        )),
    const Item(
        'Type',
        Icon(
          Icons.movie_filter,
          color: NavBar.menuIconColor,
        )),
    const Item(
        'Genre',
        Icon(
          Icons.ac_unit,
          color: NavBar.menuIconColor,
        )),
    const Item(
        'Actor',
        Icon(
          Icons.recent_actors,
          color: NavBar.menuIconColor,
        )),
    const Item(
        'Director',
        Icon(
          Icons.recent_actors_sharp,
          color: NavBar.menuIconColor,
        )),
    const Item(
        'Detail',
        Icon(
          Icons.details,
          color: NavBar.menuIconColor,
        )),
  ];
  //selected Menu
  String condition;
  //Animation effect var
  final VisibilityBloc visibilityBloc = VisibilityBloc();
  final submitText = TextEditingController();
  var isSearchOpen = false;
  //SearchBar Width for Layout
  var searchBarWidthstate;
  //textFont var
  final redColor = Colors.red[200];

  @override
  Widget build(BuildContext context) {
    //initial conditionMenu
    Item selectedMenu = conditionMenu[0];
    final menuBloc = MenuBloc();
    return Row(
      children: [
        StreamBuilder<bool>(
            stream: visibilityBloc.visiblity,
            initialData: false,
            builder: (context, snapshot) {
              isSearchOpen = snapshot.data;
              return AnimatedOpacity(
                  opacity: snapshot.data ? 1.0 : 0.0,
                  duration: Duration(milliseconds: 500),
                  child: Container(
                    width: ResponsiveLayout.isSmallScreen(context) ? 100 : 200,
                    height: 30,
                    child: TextField(
                      controller: submitText,
                      onSubmitted: handleSubmit,
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: redColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: redColor))),
                    ),
                  ));
            }),
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
                    //나중에 수정해야 함 DetailPage만들고..
                    if (selectedMenu.name == 'Detail')
                      widget.bloc.goToSearchPage('', pageBloc, condition: '');
                    else if (selectedMenu.name == 'Type')
                      condition = 'type';
                    else if (selectedMenu.name == 'Genre')
                      condition = 'genre';
                    else if (selectedMenu.name == 'Actor')
                      condition = 'actor';
                    else if (selectedMenu.name == 'Director')
                      condition = 'director';

                    setState(() {});
                  },
                  items: conditionMenu.map((Item menu) {
                    return DropdownMenuItem<Item>(
                        value: menu,
                        onTap: () {
                          selectedMenu = menu;
                          print(selectedMenu.name);
                          setState(() {});
                        },
                        child: Row(children: [
                          SizedBox(width: 5),
                          Text(menu.name,
                              style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                fontSize: 17,
                                color: redColor,
                              )))
                        ]));
                  }).toList());
            }),
        InkWell(
            borderRadius: BorderRadius.circular(10.0),
            onTap: () {
              isSearchOpen
                  ? handleSubmit(submitText.text)
                  : visibilityBloc.makeVisible();
            },
            child: Icon(
              Icons.search_rounded,
              color: redColor,
              size: 30,
            )),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  void handleSubmit(String value) {
    widget.bloc.goToSearchPage(value, pageBloc, condition: condition);
  }
}
