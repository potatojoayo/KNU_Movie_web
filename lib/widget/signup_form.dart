import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/utils/validation.dart';
import 'package:knu_movie_web/widget/my_text_form_field.dart';
import 'package:knu_movie_web/widget/texts.dart';

class SignUpForm extends StatefulWidget {
  final pageBloc;
  SignUpForm(this.pageBloc);
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _registerFormKey = GlobalKey<FormState>();

  final validator = ValidationMixin();
  Color textColor1;
  Color textColor2;

  String _email = '';
  String _password = '';
  String _fname = '';
  String _lname = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          emailRow(context),
          passwordRow(context),
          inputRow("first name : ", context),
          inputRow("last name : ", context),
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
        if (_registerFormKey.currentState.validate()) {
          _registerFormKey.currentState.save();
          final api = API();

          final faccount = api.signup(_email, _password, _fname, _lname);
          final account = await faccount;

          User.email = account.email;
          if (User.email != null) {
            User.uid = account.uid;
            User.password = account.password;
            User.lname = account.lastName;
            User.fname = account.firstName;
            User.sid = account.sid;
            User.address = account.address;
            User.birthday = account.birthday;
            User.job = account.job;
            User.phone = account.phone;
            User.sex = account.sex;
            Scaffold.of(context)
                // ignore: deprecated_member_use
                .showSnackBar(SnackBar(content: Text('Login success!')));
            widget.pageBloc.goToLandingPage();
          }
        }
      },
    );
  }

  Row passwordRow(BuildContext context) {
    return Row(children: [
      MyText().smallText("Password : ", context),
      SizedBox(
        width: 15,
      ),
      Flexible(
          child: MyTextFormField(
        (value) {
          _password = value;
        },
        isPassword: true,
        validator: (value) {
          validator.validatePassword(value);
        },
      )),
    ]);
  }

  Row emailRow(BuildContext context) {
    return Row(children: [
      MyText().smallText("Email : ", context),
      SizedBox(
        width: 15,
      ),
      Flexible(
          child: MyTextFormField(
        (value) {
          _email = value;
        },
        validator: (value) {
          return validator.validateEmail(value);
        },
      )),
    ]);
  }

  Row inputRow(String text, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      Flexible(
        child: MyTextFormField(
          (value) {
            if (text.contains('first')) {
              _fname = value;
            } else {
              _lname = value;
            }
          },
          validator: (value) {
            return validator.validateEmpty(value);
          },
        ),
      ),
    ]);
  }
}
