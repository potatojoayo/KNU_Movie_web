import 'package:flutter/material.dart';
import 'package:knu_movie_web/widget/form_page_form_widget.dart';
import 'package:knu_movie_web/widget/update_account_form.dart';

class UpdateAccountPage extends StatelessWidget {
  const UpdateAccountPage(this.pageBloc, {Key key}) : super(key: key);
  final pageBloc;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormPageForm(
        pageBloc: pageBloc,
        mainText: "update",
        form: UpdateAccountForm(pageBloc),
        icon: Icons.update,
        mainButton: Container(),
      ),
    );
  }
}
