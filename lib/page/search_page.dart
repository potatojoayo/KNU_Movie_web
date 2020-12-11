import 'package:flutter/material.dart';
import 'package:knu_movie_web/bloc/movie_bloc.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/model/conditionValue.dart';
import 'package:knu_movie_web/model/movie.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/widget/my_container.dart';
import 'package:knu_movie_web/widget/texts.dart';

class SearchPage extends StatelessWidget {
  SearchPage(this.value, this.pageBloc, this.conditionValue);
  final value;
  final PageBloc pageBloc;
  final List<ConditionValue> conditionValue;
  @override
  Widget build(BuildContext context) {
    bool isLarge = ResponsiveLayout.isLargeScreen(context);
    bool isMedium = ResponsiveLayout.isMediumScreen(context);
    var _rowItemCount = 5;
    if (isLarge)
      _rowItemCount = 6;
    else if (isMedium)
      _rowItemCount = 5;
    else
      _rowItemCount = 4;
    Size size = MediaQuery.of(context).size;
    final movieBloc = MovieBloc();
    movieBloc.fetchSearchList(User.uid != null ? User.uid : 1, conditionValue);

    return Padding(
        padding: EdgeInsets.only(
            left: isLarge
                ? MyPadding.mediaWidth(context)
                : MyPadding.normalHorizontal,
            right: isLarge
                ? MyPadding.mediaWidth(context)
                : MyPadding.normalHorizontal,
            bottom: MediaQuery.of(context).size.height / 10),
        child: MyContainer(
          width: size.width,
          height: size.height / 1.2,
          child: StreamBuilder(
            stream: movieBloc.searchList,
            initialData: <Movie>[],
            builder:
                (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
              if (snapshot.data.length == 0)
                return Center(
                  child: Container(
                    child: MyText().subTitleBoldText("No Result", context),
                  ),
                );
              else
                return Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _rowItemCount,
                        childAspectRatio: 2 / 3,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      String image = snapshot.data[index].postImage;
                      return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: InkWell(
                          onHover: (value) {},
                          onTap: () {
                            pageBloc
                                .goToMoviePage(snapshot.data[index].movieId);
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 5.0,
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: Image.network(
                              image,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
            },
          ),
          context: context,
        ));
  }
}
