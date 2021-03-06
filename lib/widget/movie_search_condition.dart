import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knu_movie_web/bloc/blocs.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/bloc/visiblilit_bloc.dart';
import 'package:knu_movie_web/main.dart';
import 'package:knu_movie_web/model/conditionValue.dart';
import 'package:knu_movie_web/model/item.dart';
import 'package:knu_movie_web/model/search_parameters.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';

class SearchBar extends StatefulWidget {
  final PageBloc bloc;
  SearchBar(this.bloc);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  //selected Menu
  String condition = 'title';
  String hintText = 'anything';
  //Animation effect var
  final VisibilityBloc visibilityBloc = VisibilityBloc();
  final submitText = TextEditingController();
  // ignore: deprecated_member_use
  List<ConditionValue> conditionValue = List<ConditionValue>();
  var isSearchOpen = false;
  //SearchBar Width for Layout
  var searchBarWidthstate;
  //textFont var
  final redColor = Colors.red[200];

  @override
  Widget build(BuildContext context) {
    //initial conditionMenu
    Item selectedMenu = Item.conditionMenu[0];
    // final menuBloc = MenuBloc();
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
                      cursorColor: redColor,
                      cursorWidth: 2,
                      style: GoogleFonts.ubuntu(
                          textStyle: TextStyle(color: redColor)),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 15),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: redColor)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: redColor))),
                    ),
                  ));
            }),
        StreamBuilder<Item>(
            stream: Blocs.menuBloc.selectedMenu,
            initialData: selectedMenu,
            builder: (context, snapshot) {
              return DropdownButton<Item>(
                  value: snapshot.data,
                  iconEnabledColor: redColor,
                  onChanged: (Item choosen) {
                    selectedMenu = choosen;
                    Blocs.menuBloc.changeItem(choosen);
                    if (selectedMenu.name == 'Detail') {
                      SearchParameters.clearParams();
                      widget.bloc.goToDetailSearchPage(widget.bloc);
                    } else if (selectedMenu.name == 'Title') {
                      condition = 'title';
                    } else if (selectedMenu.name == 'Type') {
                      condition = 'type';
                      hintText = 'tvseries, movie, knuMovie';
                    } else if (selectedMenu.name == 'Genre') {
                      condition = 'genre';
                      hintText = 'tvSeries, movie, knuMovie';
                    } else if (selectedMenu.name == 'Actor') {
                      condition = 'actor';
                      hintText = 'tvSeries, movie, knuMovie';
                    } else if (selectedMenu.name == 'Director') {
                      condition = 'director';
                      hintText = 'tvSeries, movie, knuMovie';
                    }

                    setState(() {});
                  },
                  items: Item.conditionMenu.map((Item menu) {
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
    conditionValue.add(ConditionValue(condition, value));
    widget.bloc.goToSearchPage(pageBloc, conditionValue);
    print(conditionValue[0].value);
  }
}
