import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/Lists.dart';
import 'package:knu_movie_web/model/new_movie.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/utils/validation.dart';
import 'package:knu_movie_web/widget/my_text_form_field.dart';
import 'package:knu_movie_web/widget/texts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:select_dialog/select_dialog.dart';

import 'my_button.dart';

class AddMovieForm extends StatefulWidget {
  final PageBloc pageBloc;
  AddMovieForm(this.pageBloc);

  @override
  _AddMovieFormState createState() => _AddMovieFormState();
}

class _AddMovieFormState extends State<AddMovieForm> {
  final _detailSearchFormKey = GlobalKey<FormState>();

  final validator = ValidationMixin();

  final types = ['movie', 'tv series', 'knu original'];

  final titleContorller = TextEditingController();
  final genreController = TextEditingController();
  final actorController = TextEditingController();
  final imageController = TextEditingController();
  final directorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _detailSearchFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          inputRow("title : ", "title", context, titleContorller),
          SizedBox(height: 10),
          selectRow('type : ', "type", types, NewMovie.type, context),
          SizedBox(height: 10),
          selectRow('genre : ', "genre", Lists.genres, NewMovie.genre, context),
          SizedBox(height: 10),
          selectRow('actor : ', "actor", Lists.actors, NewMovie.actor, context),
          SizedBox(height: 10),
          selectRow('director : ', "director", Lists.directors,
              NewMovie.director, context),
          SizedBox(height: 10),
          startDatePickerRow('start-year : ', context),
          SizedBox(height: 10),
          endDatePickerRow('end-year : ', context),
          SizedBox(height: 10),
          numberPickerRow(
              "running time : ", NewMovie.runningTime, 0, 500, 100, context),
          SizedBox(height: 10),
          inputRow("image : ", "image", context, imageController),
          SizedBox(height: 10),
          SizedBox(
            height: 30,
          ),
          submitButton(context)
        ],
      ),
    );
  }

  Row inputRow(text, input, BuildContext context, controller) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      Flexible(
          child: MyTextFormField(
        (value) {},
        controller: controller,
      )),
    ]);
  }

  Row selectRow(text, category, list, searchParam, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      myButton(category, searchParam, list, _openSelectDialog, context)
    ]);
  }

  RaisedButton myButton(
      category, searchParam, list, openSelectDialog, BuildContext context) {
    return RaisedButton(
      onPressed: () {
        openSelectDialog(category, searchParam, list);
      },
      child: MyText()
          .smallText(searchParam == null ? 'select' : searchParam, context),
      disabledColor: MyColor.grey,
      focusColor: MyColor.grey,
    );
  }

  void _openSelectDialog(String label, searchParam, list) {
    SelectDialog.showModal<String>(context,
        label: label,
        titleStyle: GoogleFonts.graduate(
          textStyle: TextStyle(
              color: Colors.red[200],
              fontWeight: FontWeight.normal,
              fontSize: ResponsiveLayout.isSmallScreen(context) ? 20 : 25),
        ),
        selectedValue: searchParam == null ? 'select' : searchParam,
        items: list, onChange: (String selected) {
      searchParam = selected;
      if (label == "type") NewMovie.type = selected;
      if (label == "genre") NewMovie.genre = selected;
      if (label == 'actor') NewMovie.actor = selected;
      if (label == 'director') NewMovie.director = selected;

      setState(() {
        print(searchParam);
      });
    });
  }

  Row numberPickerRow(text, attr, minValue, maxValue, initialIntegerValue,
      BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      Flexible(
          child: RaisedButton(
        onPressed: () {
          _showDialog(text, attr, minValue, maxValue, initialIntegerValue);
        },
        child: MyText()
            .smallText(attr != null ? attr.toString() : "select", context),
        disabledColor: MyColor.grey,
        focusColor: MyColor.grey,
      )),
    ]);
  }

  void _showDialog(text, attr, minValue, maxValue, initialIntegerValue) {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: minValue,
            maxValue: maxValue,
            initialIntegerValue: initialIntegerValue,
            title: MyText().smallText(text, context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
            ),
          );
        }).then((value) {
      if (value != null)
        setState(() {
          if (attr == NewMovie.runningTime) {
            NewMovie.runningTime = value;
          }
        });
    });
  }

  int genreToGen() {
    int gen = 0;
    switch (NewMovie.genre.toLowerCase()) {
      case 'action':
        gen = 1;
        break;
      case 'adventure':
        gen = 2;
        break;
      case 'animation':
        gen = 3;
        break;
      case 'biography':
        gen = 4;
        break;
      case 'comedy':
        gen = 5;
        break;
      case 'crime':
        gen = 6;
        break;
      case 'drama':
        gen = 7;
        break;
      case 'family':
        gen = 8;
        break;
      case 'horror':
        gen = 9;
        break;
      case 'mystery':
        gen = 10;
        break;
      case 'romance':
        gen = 11;
        break;
      case 'sci-fi':
        gen = 12;
        break;
      case 'thriller':
        gen = 13;
        break;
      case 'fantasy':
        gen = 14;
        break;
    }
    return gen;
  }

  Row startDatePickerRow(text, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      MyButton(
          child: MyText().smallText(
              NewMovie.startYear != null
                  ? DateFormat('yyyy-MM-dd').format(NewMovie.startYear)
                  : 'select',
              context),
          context: context,
          onPressed: () {
            Future<DateTime> selectedDate = showDatePicker(
                context: context,
                initialDate: NewMovie.startYear ?? DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget child) {
                  return Theme(data: ThemeData.light(), child: child);
                });

            selectedDate.then((dateTime) {
              setState(() {
                NewMovie.startYear = dateTime;
              });
            });
          })
    ]);
  }

  Row endDatePickerRow(text, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      MyButton(
          child: MyText().smallText(
              NewMovie.endYear != null
                  ? DateFormat('yyyy-MM-dd').format(NewMovie.endYear)
                  : 'select',
              context),
          context: context,
          onPressed: () {
            Future<DateTime> selectedDate = showDatePicker(
                context: context,
                initialDate: NewMovie.endYear ?? DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget child) {
                  return Theme(data: ThemeData.light(), child: child);
                });

            selectedDate.then((dateTime) {
              setState(() {
                NewMovie.endYear = dateTime;
              });
            });
          })
    ]);
  }

  RaisedButton submitButton(BuildContext context) {
    return RaisedButton(
      child: MyText().smallTextGrey("submit", context),
      disabledColor: MyColor.red,
      color: MyColor.red,
      onPressed: () async {
        if (titleContorller.text.isNotEmpty)
          NewMovie.title = titleContorller.text;
        if (genreController.text.isNotEmpty)
          NewMovie.genre = genreController.text;
        if (NewMovie.type != null)
          NewMovie.type = NewMovie.type.replaceAll(" ", "");
        if (actorController.text.isNotEmpty)
          NewMovie.actor = actorController.text;
        if (directorController.text.isNotEmpty)
          NewMovie.director = directorController.text;
        if (imageController.text.isNotEmpty)
          NewMovie.image = imageController.text;

        if (NewMovie.isNull()) {
          Scaffold.of(context)
              // ignore: deprecated_member_use
              .showSnackBar(SnackBar(
                  content: Text('Please fill up all except end_year')));
          return null;
        }

        final api = API();
        final insertedMovie = await api.crudMovie(
          mode: 'register',
          title: NewMovie.title,
          type: NewMovie.type,
          isAdult: 'false',
        );

        if (NewMovie.genre != null) {
          int _gen = genreToGen();
          api.crudMovie(
              mode: 'add_genre',
              gen: _gen.toString(),
              mid: insertedMovie.movieId.toString());
        }
        if (NewMovie.image != null) {
          api.crudMovie(
              image: NewMovie.image, mid: insertedMovie.movieId.toString());
        }
        if (NewMovie.actor != null) {
          int index = Lists.actorsWithAids
              .indexWhere((element) => element.name == NewMovie.actor);
          api.crudMovie(
              mode: 'add_actor',
              aid: Lists.actorsWithAids[index].id.toString(),
              mid: insertedMovie.movieId.toString());
        }
        if (NewMovie.director != null) {
          int index = Lists.directorWithDids
              .indexWhere((element) => element.name == NewMovie.director);
          api.crudMovie(
              mode: 'add_director',
              aid: Lists.directorWithDids[index].id.toString(),
              mid: insertedMovie.movieId.toString());
        }

        if (NewMovie.startYear != null)
          api.crudMovie(
              mid: insertedMovie.movieId.toString(),
              startYear: DateFormat('yyyy-MM-dd').format(NewMovie.startYear));

        if (NewMovie.endYear != null)
          api.crudMovie(
              mid: insertedMovie.movieId.toString(),
              endYear: DateFormat('yyyy-MM-dd').format(NewMovie.endYear));

        if (NewMovie.runningTime != null)
          api.crudMovie(
              mid: insertedMovie.movieId.toString(),
              runningTime: NewMovie.runningTime.toString());

        if (NewMovie.image != null)
          api.crudMovie(
              mid: insertedMovie.movieId.toString(), image: NewMovie.image);
        else
          api.crudMovie(
              mid: insertedMovie.movieId.toString(),
              image:
                  "https://everyfad.com/static/images/movie_poster_placeholder.29ca1c87.svg");

        print(NewMovie.image);

        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(
            SnackBar(content: MyText().smallText("MOVIE ADDED!", context)));

        NewMovie.clearNewMovie();
      },
    );
  }
}
