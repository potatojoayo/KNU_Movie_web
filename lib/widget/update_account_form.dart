import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/color/color.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/model/account.dart';
import 'package:knu_movie_web/model/conditionValue.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/utils/validation.dart';
import 'package:knu_movie_web/widget/my_button.dart';
import 'package:knu_movie_web/widget/my_text_form_field.dart';
import 'package:knu_movie_web/widget/texts.dart';
import 'package:select_dialog/select_dialog.dart';

const basic = 1;
const premium = 2;
const prime = 3;

class UpdateAccountForm extends StatefulWidget {
  final pageBloc;
  UpdateAccountForm(this.pageBloc);

  @override
  _UpdateAccountFormState createState() => _UpdateAccountFormState();
}

class _UpdateAccountFormState extends State<UpdateAccountForm> {
  final _updateFormKey = GlobalKey<FormState>();

  final validator = ValidationMixin();
  Color textColor1;
  Color textColor2;

  String _password;
  String _fname;
  String _lname;
  String _address;
  String _job;
  String _phone;
  String _phone1;
  String _phone2;
  String _phone3;
  String _sex;
  DateTime _birthday;
  int _sid = User.sid;

  final memList = ['basic', 'premium', 'prime'];

  Color maleTextColor = MyColor.red;
  Color maleButtonColor = MyColor.grey;
  Color femaleTextColor = MyColor.red;
  Color femaleButtonColor = MyColor.grey;

  @override
  Widget build(BuildContext context) {
    if (_sex == 'male') {
      maleTextColor = MyColor.grey;
      maleButtonColor = MyColor.red;
      femaleTextColor = MyColor.red;
      femaleButtonColor = MyColor.grey;
    } else if (_sex == 'female') {
      femaleTextColor = MyColor.grey;
      femaleButtonColor = MyColor.red;
      maleTextColor = MyColor.red;
      maleButtonColor = MyColor.grey;
    } else {
      maleTextColor = MyColor.red;
      maleButtonColor = MyColor.grey;
      femaleTextColor = MyColor.red;
      femaleButtonColor = MyColor.grey;
    }
    return Form(
      key: _updateFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          passwordRow(context),
          updateInputRow(
              "first name : ", User.fname, validator.validateEmpty, context),
          updateInputRow(
              "last name : ", User.lname, validator.validateEmpty, context),
          SizedBox(height: 15),
          genderRow("sex : ", context),
          SizedBox(height: 10),
          phoneRow("phone : ", User.phone, context),
          SizedBox(height: 15),
          datePickerRow("birthday : ", context),
          SizedBox(height: 10),
          updateInputRow("address : ", User.address, null, context),
          updateInputRow("job : ", User.job, null, context),
          SizedBox(height: 10),
          selectRow(memList, context),
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
        if (_updateFormKey.currentState.validate()) {
          _updateFormKey.currentState.save();
          final api = API();

          List<ConditionValue> cvs = [];

          if (_phone1 != null && _phone2 != null && _phone3 != null)
            _phone = _phone1 + "-" + _phone2 + "-" + _phone3;

          String _bdate;
          if (_birthday != null)
            _bdate = DateFormat('yyyy-MM-dd').format(_birthday);

          if (_password != null) cvs.add(ConditionValue('password', _password));
          if (_fname != null) cvs.add(ConditionValue('first_name', _fname));
          if (_lname != null) cvs.add(ConditionValue('last_name', _lname));
          if (_address != null) cvs.add(ConditionValue('address', _address));
          if (_job != null) cvs.add(ConditionValue('job', _job));
          if (_phone != null) cvs.add(ConditionValue('phone', _phone));
          if (_sex != null) cvs.add(ConditionValue('sex', _sex));
          if (_sid != null) cvs.add(ConditionValue('sid', _sid.toString()));
          if (_bdate != null) cvs.add(ConditionValue('birthday', _bdate));

          Account account;

          for (ConditionValue c in cvs) {
            account = await api.updateAccount(User.email, c.condition, c.value);
          }

          if (account != null) {
            User.email = account.email;
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
                .showSnackBar(SnackBar(content: Text('Updated!')));
            //TODO
            // widget.pageBloc.goToLandingPage();
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
          if (value.isNotEmpty) _password = value;
        },
        isPassword: true,
        validator: (value) {
          validator.validatePassword(value);
        },
      )),
    ]);
  }

  Row updateInputRow(String text, initValue, validator, BuildContext context) {
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
          } else if (text.contains('last')) {
            _lname = value;
          } else if (text.contains('address')) {
            _address = value;
          } else if (text.contains('job')) {
            _job = value;
          }

          setState(() {});
        },
        initValue: initValue ?? null,
        validator: validator ?? null,
      )),
    ]);
  }

  Row phoneRow(text, initValue, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      Flexible(
        child: MyTextFormField(
          (value) {
            _phone1 = value;
          },
          initValue: initValue != null ? initValue.substring(0, 3) : null,
        ),
      ),
      MyText().smallText('   -   ', context),
      Flexible(
          child: MyTextFormField((value) {
        _phone2 = value;
      }, initValue: initValue != null ? initValue.substring(4, 8) : null)),
      MyText().smallText('   -   ', context),
      Flexible(
          child: MyTextFormField((value) {
        _phone3 = value;
      }, initValue: initValue != null ? initValue.substring(9, 13) : null)),
    ]);
  }

  Row genderRow(text, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      MyButton(
        child: MyText().smallTextSelectColor("male", context, maleTextColor),
        context: context,
        onPressed: () {
          if (maleButtonColor == MyColor.red) {
            // maleButtonColor = MyColor.grey;
            // maleTextColor = MyColor.red;
            _sex = null;
          } else {
            _sex = 'male';
            // maleButtonColor = MyColor.red;
            // maleTextColor = MyColor.grey;
            // femaleButtonColor = MyColor.grey;
            // femaleTextColor = MyColor.red;
          }
          setState(() {});
        },
        buttonColor: maleButtonColor,
      ),
      SizedBox(
        width: 10,
      ),
      MyButton(
        child:
            MyText().smallTextSelectColor("female", context, femaleTextColor),
        context: context,
        onPressed: () {
          if (femaleButtonColor == MyColor.red) {
            // femaleButtonColor = MyColor.grey;
            // femaleTextColor = MyColor.red;
            _sex = null;
          } else {
            _sex = 'female';
            // femaleButtonColor = MyColor.red;
            // femaleTextColor = MyColor.grey;
            // maleButtonColor = MyColor.grey;
            // maleTextColor = MyColor.red;
          }
          setState(() {});
        },
        buttonColor: femaleButtonColor,
      )
    ]);
  }

  Row datePickerRow(text, BuildContext context) {
    return Row(children: [
      MyText().smallText(text, context),
      SizedBox(
        width: 15,
      ),
      MyButton(
          child: MyText().smallText(
              _birthday != null
                  ? DateFormat('yyyy-MM-dd').format(_birthday)
                  : 'select',
              context),
          context: context,
          onPressed: () {
            Future<DateTime> selectedDate = showDatePicker(
                context: context,
                initialDate: _birthday ?? DateTime(2000),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (BuildContext context, Widget child) {
                  return Theme(data: ThemeData.light(), child: child);
                });

            selectedDate.then((dateTime) {
              setState(() {
                _birthday = dateTime;
              });
            });
          })
    ]);
  }

  // 셀렉트 로우

  Row selectRow(list, BuildContext context) {
    return Row(children: [
      MyText().smallText("membership : ", context),
      SizedBox(
        width: 15,
      ),
      selectButton(list, _openSelectDialog, context)
    ]);
  }

  RaisedButton selectButton(list, openSelectDialog, BuildContext context) {
    return RaisedButton(
      onPressed: () {
        openSelectDialog(list);
      },
      child: MyText().smallText(
          _sid == null
              ? 'select'
              : _sid == basic
                  ? 'basic'
                  : _sid == premium
                      ? 'premium'
                      : 'prime',
          context),
      disabledColor: MyColor.grey,
      focusColor: MyColor.grey,
    );
  }

  void _openSelectDialog(list) {
    SelectDialog.showModal<String>(context,
        label: "membership",
        titleStyle: GoogleFonts.graduate(
          textStyle: TextStyle(
              color: Colors.red[200],
              fontWeight: FontWeight.normal,
              fontSize: ResponsiveLayout.isSmallScreen(context) ? 20 : 25),
        ),
        selectedValue: _sid == basic
            ? 'basic'
            : _sid == premium
                ? 'premium'
                : 'prime',
        items: list, onChange: (String selected) {
      if (selected == 'basic')
        _sid = basic;
      else if (selected == 'premium')
        _sid = premium;
      else
        _sid = prime;

      setState(() {});
    });
  }
}
