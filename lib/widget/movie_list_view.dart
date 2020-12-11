import 'package:flutter/material.dart';
import 'package:knu_movie_web/bloc/page_bloc.dart';
import 'package:knu_movie_web/model/movie.dart';

class MovieListView extends StatelessWidget {
  final list;
  final PageBloc bloc;
  const MovieListView(this.list, this.bloc, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: list,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData)
          return Container();
        else
          return ListView.builder(
            itemCount: snapshot.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String image = snapshot.data[index].postImage;
              return Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: InkWell(
                  onHover: (value) {},
                  onTap: () {
                    bloc.goToMoviePage(snapshot.data[index].movieId);
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
          );
      },
    );
  }
}
