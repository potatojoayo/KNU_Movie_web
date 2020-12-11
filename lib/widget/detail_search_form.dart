import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/model/conditionValue.dart';
import 'package:knu_movie_web/utils/validation.dart';
import 'package:knu_movie_web/widget/my_text_form_field.dart';
import 'package:knu_movie_web/widget/texts.dart';
import 'package:numberpicker/numberpicker.dart';

class DetailSearchForm extends StatefulWidget {
  final PageBloc pageBloc;
  DetailSearchForm(this.pageBloc);
  @override
  _DetailSearchFormState createState() => _DetailSearchFormState();
}

class _DetailSearchFormState extends State<DetailSearchForm> {
  final _detailSearchFormKey = GlobalKey<FormState>();

  final validator = ValidationMixin();
  String _title;
  String _genre;
  String _type;
  int _minStartYear;
  int _maxStartYear;
  String _actor;
  String _director;
  int _minRating;
  int _maxRating;

  final titleContorller = TextEditingController();
  final genreController = TextEditingController();
  final typeController = TextEditingController();
  final actorController = TextEditingController();
  final directorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (_minStartYear != null && _maxStartYear == null) _maxStartYear = 2020;
    if (_maxStartYear != null && _minStartYear == null) _minStartYear = 1900;
    if (_minRating != null && _maxRating == null) _maxRating = 10;
    if (_maxRating != null && _minRating == null) _minRating = 0;
    if (_minStartYear != null &&
        _maxStartYear != null &&
        (_minStartYear > _maxStartYear)) _maxStartYear = _minStartYear;
    if (_minRating != null && _maxRating != null && (_minRating > _maxRating))
      _maxRating = _minRating;
    return Form(
      key: _detailSearchFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          inputRow("title : ", "title", context, titleContorller),
          inputRow("genre : ", "genre", context, genreController),
          inputRow("type : ", "type", context, typeController),
          inputRow("actor : ", "actor", context, actorController),
          inputRow("director : ", "director", context, directorController),
          SizedBox(height: 10),
          numberPickerRow("min rating : ", _minRating, 0, 10,
              _minRating != null ? _minRating : 5, context),
          SizedBox(height: 10),
          numberPickerRow("max rating : ", _maxRating, 0, 10,
              _maxRating != null ? _maxRating : 5, context),
          SizedBox(height: 10),
          numberPickerRow("min start-year : ", _minStartYear, 1900, 2020,
              _minStartYear != null ? _minStartYear : 1990, context),
          SizedBox(height: 10),
          numberPickerRow("max start-year : ", _maxStartYear, 1900, 2020,
              _maxStartYear != null ? _maxStartYear : 2000, context),
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
        _title = titleContorller.text;
        _genre = genreController.text;
        _type = typeController.text;
        _actor = actorController.text;
        _director = directorController.text;
        List<ConditionValue> conditions = List<ConditionValue>();
        if (_title != "") conditions.add(ConditionValue("title", _title));
        if (_genre != "") conditions.add(ConditionValue("genre", _genre));
        if (_type != "") conditions.add(ConditionValue("type", _type));
        if (_actor != "") conditions.add(ConditionValue("actor", _actor));
        if (_director != "")
          conditions.add(ConditionValue("director", _director));
        if (_minStartYear != null)
          conditions
              .add(ConditionValue("minStartYear", _minStartYear.toString()));
        if (_maxStartYear != null)
          conditions
              .add(ConditionValue("maxStartYear", _maxStartYear.toString()));
        if (_minRating != null)
          conditions.add(ConditionValue("minRating", _minRating.toString()));
        if (_maxRating != null)
          conditions.add(ConditionValue("maxRating", _maxRating.toString()));
        print(_title);
        for (ConditionValue c in conditions) {
          print(c.value);
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
        (value) {
          setState(() {
            if (input == "title") _title = value;
            if (input == "genre") _genre = value;
            if (input == "type") _type = value;
            if (input == "actor") _actor = value;
            if (input == "director") _director = value;
          });
        },
        controller: controller,
      )),
    ]);
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
          if (attr == _minRating) {
            _minRating = value;
          } else if (attr == _maxRating) {
            _maxRating = value;
          } else if (attr == _minStartYear) {
            _minStartYear = value;
          } else {
            _maxStartYear = value;
          }
        });
    });
  }
}
