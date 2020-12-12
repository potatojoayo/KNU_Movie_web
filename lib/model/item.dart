import 'package:flutter/material.dart';
import 'package:knu_movie_web/nav/nav_bar.dart';

class Item {
  Item(this.name, this.icon);
  final String name;
  final Icon icon;

  static List<Item> conditionMenu = <Item>[
    Item(
        'Title',
        Icon(
          Icons.search,
          color: NavBar.menuIconColor,
        )),
    Item(
        'Type',
        Icon(
          Icons.movie_filter,
          color: NavBar.menuIconColor,
        )),
    Item(
        'Genre',
        Icon(
          Icons.ac_unit,
          color: NavBar.menuIconColor,
        )),
    Item(
        'Actor',
        Icon(
          Icons.recent_actors,
          color: NavBar.menuIconColor,
        )),
    Item(
        'Director',
        Icon(
          Icons.recent_actors_sharp,
          color: NavBar.menuIconColor,
        )),
    Item(
        'Detail',
        Icon(
          Icons.details,
          color: NavBar.menuIconColor,
        )),
  ];
}
