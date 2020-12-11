import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/utils/validation.dart';
import 'package:knu_movie_web/widget/my_text_form_field.dart';
import 'package:knu_movie_web/widget/texts.dart';
import 'package:numberpicker/numberpicker.dart';

class DetailSearchForm extends StatefulWidget {
  final pageBloc;
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
          inputRow("title : ", _title, context),
          inputRow("genre : ", _genre, context),
          inputRow("type : ", _type, context),
          inputRow("actor : ", _actor, context),
          inputRow("director : ", _director, context),
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
      onPressed: () async {
        if (_detailSearchFormKey.currentState.validate()) {
          _detailSearchFormKey.currentState.save();
          final api = API();
          final fmovies = api.selectMovie(
            User.uid,
            title: _title != null ? _title : null,
            genre: _genre != null ? _genre : null,
            type: _type != null ? _type : null,
            actor: _actor != null ? _actor : null,
            director: _director != null ? _director : null,
            minStartYear: _minStartYear != null ? _minStartYear : null,
            maxStartYear: _minStartYear != null ? _maxStartYear : null,
            minRating: _minRating != null ? _minRating : null,
            maxRating: _minRating != null ? _maxRating : null,
          );
        }
      },
    );
  }

  Row inputRow(text, input, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      Flexible(child: MyTextFormField(
        (value) {
          input = value;
        },
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
