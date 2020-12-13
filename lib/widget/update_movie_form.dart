import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/Lists.dart';
import 'package:knu_movie_web/model/movie_to_update.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/utils/validation.dart';
import 'package:knu_movie_web/widget/my_text_form_field.dart';
import 'package:knu_movie_web/widget/texts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:select_dialog/select_dialog.dart';

import 'my_button.dart';

class UpdateMovieForm extends StatefulWidget {
  final PageBloc pageBloc;
  UpdateMovieForm(this.pageBloc);

  @override
  _UpdateMovieFormState createState() => _UpdateMovieFormState();
}

class _UpdateMovieFormState extends State<UpdateMovieForm> {
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
          inputRow("title : ", "title", MovieToUpdate.title, context,
              titleContorller),
          SizedBox(height: 10),
          selectRow('type : ', "type", types, MovieToUpdate.type, context),
          SizedBox(height: 10),
          selectRow(
              'genre : ', "genre", Lists.genres, MovieToUpdate.genre, context),
          SizedBox(height: 10),
          actorRow('actor : ', context),
          SizedBox(height: 10),
          selectRow('director : ', "director", Lists.directors,
              MovieToUpdate.director, context),
          SizedBox(height: 10),
          startDatePickerRow('start-year : ', context),
          SizedBox(height: 10),
          endDatePickerRow('end-year : ', context),
          SizedBox(height: 10),
          numberPickerRow("running time : ", MovieToUpdate.runningTime, 0, 500,
              100, context),
          SizedBox(height: 10),
          inputRow("image : ", "image", MovieToUpdate.image, context,
              imageController),
          SizedBox(height: 10),
          SizedBox(
            height: 30,
          ),
          submitButton(context)
        ],
      ),
    );
  }

  Row inputRow(text, input, init, BuildContext context, controller) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      Flexible(
          child: MyTextFormField(
        (value) {},
        initValue: init ?? null,
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

  Row genreRow(text, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      myButton('add genre', "add", Lists.genres, _openSelectDialog, context),
      SizedBox(
        width: 10,
      ),
      myButton('delete genre', "delete", MovieToUpdate.genre, _openSelectDialog,
          context),
    ]);
  }

  Row actorRow(text, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      myButton('add actor', "add", Lists.actors, _openSelectDialog, context),
      SizedBox(
        width: 10,
      ),
      myButton('delete actor', "delete", MovieToUpdate.actor, _openSelectDialog,
          context),
    ]);
  }

  // Row directorRow(text, BuildContext context) {
  //   return Row(children: [
  //     MyText().smallText(text, context),
  //     SizedBox(
  //       width: 15,
  //     ),
  //     myButton(
  //         'add director', "add", Lists.directors, _openSelectDialog, context),
  //     SizedBox(
  //       width: 10,
  //     ),
  //     myButton('delete director', "delete", MovieToUpdate.director,
  //         _openSelectDialog, context),
  //   ]);
  // }

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
      final api = API();
      searchParam = selected;
      if (label == "type") MovieToUpdate.type = selected;
      if (label == 'add actor') {
        MovieToUpdate.actor.add(selected);
        final aid = Lists.actorsWithAids
            .firstWhere((element) => element.name == selected)
            .id;
        api.crudMovie(
            mode: 'add_actor', aid: aid, mid: MovieToUpdate.mid.toString());
      }
      if (label == 'delete actor') {
        final aid = Lists.actorsWithAids
            .firstWhere((element) => element.name == selected)
            .id;

        MovieToUpdate.actor.removeWhere((element) => element == selected);

        api.crudMovie(
            mode: 'delete_actor', aid: aid, mid: MovieToUpdate.mid.toString());
      }
      // if (label == 'add director') {
      //   MovieToUpdate.director.add(selected);
      //   final did = Lists.directorWithDids
      //       .firstWhere((element) => element.name == selected)
      //       .id;
      //   api.crudMovie(
      //       mode: 'add_director', did: did, mid: MovieToUpdate.mid.toString());
      // }
      // if (label == 'delete director') {
      //   final did = Lists.directorWithDids
      //       .firstWhere((element) => element.name == selected)
      //       .id;
      //   MovieToUpdate.director.removeWhere((element) => element == selected);

      //   api.crudMovie(
      //       mode: 'delete_director',
      //       did: did,
      //       mid: MovieToUpdate.mid.toString());
      // }

      if (label == 'add genre') {
        MovieToUpdate.genre.add(selected);
        final gen = genreToGen(selected);

        api.crudMovie(
            mode: 'add_genre',
            gen: gen.toString(),
            mid: MovieToUpdate.mid.toString());
      }
      if (label == 'delete genre') {
        final gen = genreToGen(selected);
        MovieToUpdate.genre.removeWhere((element) => element == selected);
        api.crudMovie(
            mode: 'delete_genre',
            gen: gen.toString(),
            mid: MovieToUpdate.mid.toString());
      }

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
          if (attr == MovieToUpdate.runningTime) {
            MovieToUpdate.runningTime = value;
          }
        });
    });
  }

  int genreToGen(genre) {
    int gen = 0;
    switch (genre) {
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
              MovieToUpdate.startYear != null
                  ? DateFormat('yyyy-MM-dd').format(MovieToUpdate.startYear)
                  : 'select',
              context),
          context: context,
          onPressed: () {
            Future<DateTime> selectedDate = showDatePicker(
                context: context,
                initialDate: MovieToUpdate.startYear ?? DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget child) {
                  return Theme(data: ThemeData.light(), child: child);
                });

            selectedDate.then((dateTime) {
              setState(() {
                MovieToUpdate.startYear = dateTime;
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
              MovieToUpdate.endYear != null
                  ? DateFormat('yyyy-MM-dd').format(MovieToUpdate.endYear)
                  : 'select',
              context),
          context: context,
          onPressed: () {
            Future<DateTime> selectedDate = showDatePicker(
                context: context,
                initialDate: MovieToUpdate.endYear ?? DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget child) {
                  return Theme(data: ThemeData.light(), child: child);
                });

            selectedDate.then((dateTime) {
              setState(() {
                MovieToUpdate.endYear = dateTime;
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
          MovieToUpdate.title = titleContorller.text;
        // if (genreController.text.isNotEmpty)
        //   MovieToUpdate.genre = genreController.text;
        if (MovieToUpdate.type != null)
          MovieToUpdate.type = MovieToUpdate.type.replaceAll(" ", "");

        if (imageController.text.isNotEmpty)
          MovieToUpdate.image = imageController.text;

        if (MovieToUpdate.isNull()) {
          Scaffold.of(context)
              // ignore: deprecated_member_use
              .showSnackBar(SnackBar(
                  content: Text('Please fill up all except end_year')));
          return null;
        }

        final api = API();
        final insertedMovie = await api.crudMovie(
          mode: 'register',
          title: MovieToUpdate.title,
          type: MovieToUpdate.type,
          isAdult: 'false',
        );

        // if (MovieToUpdate.genre != null) {
        //   int _gen = genreToGen();
        //   api.crudMovie(
        //       mode: 'add_genre',
        //       gen: _gen.toString(),
        //       mid: insertedMovie.movieId.toString());
        // }
        if (MovieToUpdate.image != null) {
          api.crudMovie(
              image: MovieToUpdate.image,
              mid: insertedMovie.movieId.toString());
        }
        // if (MovieToUpdate.actor != null) {
        //   int index = Lists.actorsWithAids
        //       .indexWhere((element) => element.name == MovieToUpdate.actor);
        //   api.crudMovie(
        //       mode: 'add_actor',
        //       aid: Lists.actorsWithAids[index].id.toString(),
        //       mid: insertedMovie.movieId.toString());
        // }
        if (MovieToUpdate.director != null) {
          int index = Lists.directorWithDids
              .indexWhere((element) => element.name == MovieToUpdate.director);
          api.crudMovie(
              mode: 'add_director',
              aid: Lists.directorWithDids[index].id.toString(),
              mid: insertedMovie.movieId.toString());
        }

        if (MovieToUpdate.startYear != null)
          api.crudMovie(
              mid: insertedMovie.movieId.toString(),
              startYear:
                  DateFormat('yyyy-MM-dd').format(MovieToUpdate.startYear));

        if (MovieToUpdate.endYear != null)
          api.crudMovie(
              mid: insertedMovie.movieId.toString(),
              endYear: DateFormat('yyyy-MM-dd').format(MovieToUpdate.endYear));

        if (MovieToUpdate.runningTime != null)
          api.crudMovie(
              mid: insertedMovie.movieId.toString(),
              runningTime: MovieToUpdate.runningTime.toString());

        if (MovieToUpdate.image != null)
          api.crudMovie(
              mid: insertedMovie.movieId.toString(),
              image: MovieToUpdate.image);
        else
          api.crudMovie(
              mid: insertedMovie.movieId.toString(),
              image:
                  "https://everyfad.com/static/images/movie_poster_placeholder.29ca1c87.svg");

        print(MovieToUpdate.image);

        MovieToUpdate.clearMovieToUpdate();
      },
    );
  }
}
