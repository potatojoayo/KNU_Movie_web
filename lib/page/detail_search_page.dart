import 'package:flutter/material.dart';
import 'package:knu_movie_web/widget/detail_search_form.dart';
import 'package:knu_movie_web/widget/form_page_form_widget.dart';

class DetailSearchPage extends StatefulWidget {
  DetailSearchPage(this.pageBloc, {Key key}) : super(key: key);

  final pageBloc;
  @override
  _DetailSearchPageState createState() => _DetailSearchPageState();
}

// 디테일 서치
// 장르
// 타입
// start_year
// rating
// director
// actor

class _DetailSearchPageState extends State<DetailSearchPage> {
  @override
  Widget build(BuildContext context) {
    return FormPageForm(
        pageBloc: widget.pageBloc,
        mainText: "Detail Search",
        icon: Icons.search,
        form: DetailSearchForm(widget.pageBloc));
  }
}
