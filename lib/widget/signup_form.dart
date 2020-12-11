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
  final _loginFormKey = GlobalKey<FormState>();

  final validator = ValidationMixin();
  List<bool> _selections = List.generate(2, (_) => false);
  Color textColor1;
  Color textColor2;

  String _email = '';
  String _password = '';
  String _fname = '';
  String _lname = '';
  String _sex = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          emailRow(context),
          passwordRow(context),
          inputRow("first name : ", _fname, context),
          inputRow("last name : ", _lname, context),
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
        if (_loginFormKey.currentState.validate()) {
          _loginFormKey.currentState.save();
          final api = API();
          api.signin(_email, _password).then((value) {
            User.email = value.email;
            if (User.email != null) {
              User.uid = value.uid;
              User.password = value.password;
              User.lname = value.lastName;
              User.fname = value.firstName;
              User.sid = value.sid;
              User.address = value.address;
              User.birthday = value.birthday;
              User.job = value.job;
              User.phone = value.phone;
              User.sex = value.sex;
              Scaffold.of(context)
                  // ignore: deprecated_member_use
                  .showSnackBar(SnackBar(content: Text('Login success!')));
              widget.pageBloc.goToLandingPage();
            }
          });
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
}