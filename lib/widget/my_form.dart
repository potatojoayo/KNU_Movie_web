import 'package:flutter/material.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/widget/my_text_field.dart';
import 'package:knu_movie_web/widget/texts.dart';

class LoginForm extends StatefulWidget {
  final pageBloc;
  LoginForm(this.pageBloc);
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();

  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          emailRow(context),
          passwordRow(context),
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
      child: MyText().smallTextGrey("Login", context),
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
      )),
    ]);
  }

  Row emailRow(BuildContext context) {
    return Row(children: [
      MyText().smallText("Email : ", context),
      SizedBox(
        width: 15,
      ),
      Flexible(child: MyTextFormField((value) {
        _email = value;
      })),
    ]);
  }
}
