import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/Lists.dart';
import 'package:knu_movie_web/model/conditionValue.dart';
import 'package:knu_movie_web/model/search_parameters.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/utils/validation.dart';
import 'package:knu_movie_web/widget/my_text_form_field.dart';
import 'package:knu_movie_web/widget/texts.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:select_dialog/select_dialog.dart';

class DetailSearchForm extends StatefulWidget {
  final PageBloc pageBloc;
  DetailSearchForm(this.pageBloc);

  @override
  _DetailSearchFormState createState() => _DetailSearchFormState();
}

class _DetailSearchFormState extends State<DetailSearchForm> {
  final _detailSearchFormKey = GlobalKey<FormState>();

  final validator = ValidationMixin();

  final types = ['movie', 'tv series', 'knu original'];

  final titleContorller = TextEditingController();
  final genreController = TextEditingController();
  final actorController = TextEditingController();
  final directorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (SearchParameters.minStartYear != null &&
        SearchParameters.maxStartYear == null)
      SearchParameters.maxStartYear = 2020;
    if (SearchParameters.maxStartYear != null &&
        SearchParameters.minStartYear == null)
      SearchParameters.minStartYear = 1900;
    if (SearchParameters.minRating != null &&
        SearchParameters.maxRating == null) SearchParameters.maxRating = 10;
    if (SearchParameters.maxRating != null &&
        SearchParameters.minRating == null) SearchParameters.minRating = 0;
    if (SearchParameters.minStartYear != null &&
        SearchParameters.maxStartYear != null &&
        (SearchParameters.minStartYear > SearchParameters.maxStartYear))
      SearchParameters.maxStartYear = SearchParameters.minStartYear;
    if (SearchParameters.minRating != null &&
        SearchParameters.maxRating != null &&
        (SearchParameters.minRating > SearchParameters.maxRating))
      SearchParameters.maxRating = SearchParameters.minRating;
    return Form(
      key: _detailSearchFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          inputRow("title : ", "title", context, titleContorller),
          SizedBox(height: 10),
          selectRow('type : ', "type", types, SearchParameters.type, context),
          SizedBox(height: 10),
          selectRow('genre : ', "genre", Lists.genres, SearchParameters.genre,
              context),
          SizedBox(height: 10),
          selectRow('actor : ', "actor", Lists.actors, SearchParameters.actor,
              context),
          SizedBox(height: 10),
          selectRow('director : ', "director", Lists.directors,
              SearchParameters.director, context),
          SizedBox(height: 10),
          numberPickerRow(
              "min rating : ",
              SearchParameters.minRating,
              0,
              10,
              SearchParameters.minRating != null
                  ? SearchParameters.minRating
                  : 5,
              context),
          SizedBox(height: 10),
          numberPickerRow(
              "max rating : ",
              SearchParameters.maxRating,
              0,
              10,
              SearchParameters.maxRating != null
                  ? SearchParameters.maxRating
                  : 5,
              context),
          SizedBox(height: 10),
          numberPickerRow(
              "min start-year : ",
              SearchParameters.minStartYear,
              1900,
              2020,
              SearchParameters.minStartYear != null
                  ? SearchParameters.minStartYear
                  : 1990,
              context),
          SizedBox(height: 10),
          numberPickerRow(
              "max start-year : ",
              SearchParameters.maxStartYear,
              1900,
              2020,
              SearchParameters.maxStartYear != null
                  ? SearchParameters.maxStartYear
                  : 2000,
              context),
          SizedBox(height: 10),
          SizedBox(
            height: 30,
          ),
          submitButton(context)
        ],
      ),
    );
  }

  RaisedButton submitButton(BuildContext context) {
    return RaisedButton(
      child: MyText().smallTextGrey("submit", context),
      disabledColor: MyColor.red,
      color: MyColor.red,
      onPressed: () {
        if (titleContorller.text.isNotEmpty)
          SearchParameters.title = titleContorller.text;
        if (genreController.text.isNotEmpty)
          SearchParameters.genre = genreController.text;
        if (SearchParameters.type != null)
          SearchParameters.type = SearchParameters.type.replaceAll(" ", "");
        if (actorController.text.isNotEmpty)
          SearchParameters.actor = actorController.text;
        if (directorController.text.isNotEmpty)
          SearchParameters.director = directorController.text;
        // ignore: deprecated_member_use
        List<ConditionValue> conditions = List<ConditionValue>();
        if (SearchParameters.title != null)
          conditions.add(
              ConditionValue("title", SearchParameters.title.toLowerCase()));
        if (SearchParameters.genre != null)
          conditions.add(
              ConditionValue("genre", SearchParameters.genre.toLowerCase()));
        if (SearchParameters.type != null)
          conditions
              .add(ConditionValue("type", SearchParameters.type.toLowerCase()));
        if (SearchParameters.actor != null)
          conditions.add(
              ConditionValue("actor", SearchParameters.actor.toLowerCase()));
        if (SearchParameters.director != null)
          conditions.add(ConditionValue(
              "director", SearchParameters.director.toLowerCase()));
        if (SearchParameters.minStartYear != null)
          conditions.add(ConditionValue(
              "minStartYear", SearchParameters.minStartYear.toString()));
        if (SearchParameters.maxStartYear != null)
          conditions.add(ConditionValue(
              "maxStartYear", SearchParameters.maxStartYear.toString()));
        if (SearchParameters.minRating != null)
          conditions.add(ConditionValue(
              "minRating", SearchParameters.minRating.toString()));
        if (SearchParameters.maxRating != null)
          conditions.add(ConditionValue(
              "maxRating", SearchParameters.maxRating.toString()));
        print(SearchParameters.title);
        for (ConditionValue c in conditions) {
          print('체크: ' + c.value);
        }
        widget.pageBloc.goToSearchPage(widget.pageBloc, conditions);
      },
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
      if (label == "type") SearchParameters.type = selected;
      if (label == "genre") SearchParameters.genre = selected;
      if (label == 'actor') SearchParameters.actor = selected;
      if (label == 'director') SearchParameters.director = selected;

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
          if (attr == SearchParameters.minRating) {
            SearchParameters.minRating = value;
          } else if (attr == SearchParameters.maxRating) {
            SearchParameters.maxRating = value;
          } else if (attr == SearchParameters.minStartYear) {
            SearchParameters.minStartYear = value;
          } else {
            SearchParameters.maxStartYear = value;
          }
        });
    });
  }
}
