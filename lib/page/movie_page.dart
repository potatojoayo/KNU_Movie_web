import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:knu_movie_web/api/API.dart';
import 'package:knu_movie_web/model/User.dart';
import 'package:knu_movie_web/model/movie.dart';
import 'package:knu_movie_web/utils/padding.dart';
import 'package:knu_movie_web/utils/responsive_layout.dart';
import 'package:knu_movie_web/widget/my_container.dart';
import 'package:knu_movie_web/widget/texts.dart';

// ignore: must_be_immutable
class MoviePage extends StatelessWidget {
  final Movie movie;
  var _rating;
  MoviePage(this.movie, this._rating);

  @override
  Widget build(BuildContext context) {
    bool isLarge = ResponsiveLayout.isLargeScreen(context);
    Size size = MediaQuery.of(context).size;
    final api = API();
    final genres = movie.genre
        .map((genre) => MyText().smallText(genre + ", ", context))
        .toList();
    genres[genres.length - 1] =
        MyText().smallText(movie.genre[genres.length - 1], context);
    final actors = movie.actor
        .map((actor) => MyText().smallText(actor + ", ", context))
        .toList();
    actors[actors.length - 1] =
        MyText().smallText(movie.actor[actors.length - 1], context);

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
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: ResponsiveLayout.isLargeScreen(context)
                        ? size.width / 5
                        : size.width / 3,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: MyPhotoCard(image: movie.postImage),
                    ),
                  ),
                  SizedBox(
                      width: ResponsiveLayout.isLargeScreen(context) ? 40 : 10),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MyText().subTitleBoldText(
                            movie.originalTitle +
                                " (" +
                                movie.startYear.substring(0, 4) +
                                ")",
                            context),
                        SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          children: genres,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MyText().smallText(
                            movie.type +
                                " | " +
                                movie.runningTime.toString() +
                                "min",
                            context),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: RatingBar.builder(
                          initialRating: movie.rating / 2 - 1,
                          itemSize:
                              ResponsiveLayout.isSmallScreen(context) ? 15 : 40,
                          allowHalfRating: true,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          unratedColor: Colors.amber.withAlpha(50),
                          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amber),
                          onRatingUpdate: null,
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        MyText().smallText(
                            "Average rating: " + movie.rating.toString(),
                            context),
                        SizedBox(
                          height: 10,
                        ),
                        MyText().smallText("Director:", context),
                        MyText().smallText(movie.director, context),
                        SizedBox(
                          height: 10,
                        ),
                        MyText().smallText("Actors:", context),
                        Wrap(
                          children: actors,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [],
                            ),
                            SizedBox(
                              width: 1,
                            ),
                            // Container(
                            //     width: ResponsiveLayout.isSmallScreen(context)
                            //         ? 100
                            //         : 150,
                            //     child: AspectRatio(
                            //         aspectRatio: 2 / 3,
                            //         child: MyPhotoCard(
                            //             image: movie.directorImage))),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: RatingBar.builder(
                              initialRating: _rating,
                              minRating: 0,
                              itemSize: ResponsiveLayout.isSmallScreen(context)
                                  ? 15
                                  : 40,
                              allowHalfRating: true,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              updateOnDrag: true,
                              unratedColor: Colors.amber.withAlpha(50),
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) =>
                                  Icon(Icons.star, color: Colors.amber),
                              onRatingUpdate: (rating) {
                                _rating = rating;
                                if (User.email != null)
                                  api.rating(
                                      User.uid.toString(),
                                      movie.movieId.toString(),
                                      _rating.toString());
                              }),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: ResponsiveLayout.isSmallScreen(context) ? 200 : 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movie.actor.length,
                  itemBuilder: (context, index) {
                    final images = [movie.directorImage, ...movie.actorImage];
                    final names = [movie.director, ...movie.actor];
                    String img = images[index];
                    String name = names[index];
                    return Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                height: ResponsiveLayout.isSmallScreen(context)
                                    ? 150
                                    : 230,
                                child: MyPhotoCard(image: img)),
                            SizedBox(child: MyText().smallText(name, context))
                          ],
                        ));
                  },
                ),
              )
            ],
          ),
          context: context,
        ));
  }
}

class MyPhotoCard extends StatelessWidget {
  const MyPhotoCard({
    Key key,
    @required this.image,
  }) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 5.0,
      semanticContainer: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Image.network(
        image,
        fit: BoxFit.fill,
      ),
    );
  }
}
