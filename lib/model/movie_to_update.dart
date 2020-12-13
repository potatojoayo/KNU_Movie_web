import 'package:intl/intl.dart';

import 'movie.dart';

class MovieToUpdate {
  static String title;
  static List<String> genre;
  static String type;
  static DateTime startYear;
  static DateTime endYear;
  static List<String> actor;
  static String director;
  static int runningTime;
  static int mid;
  static int gen;
  static String image;

  static void setMovieToUpdate(Movie movie) {
    title = movie.originalTitle;
    for (String g in movie.genre) {
      genre.add(g);
    }
    type = movie.type;
    startYear = DateFormat('yyyy-MM-dd').parse(movie.startYear);
    endYear = DateFormat('yyyy-MM-dd').parse(movie.endYear);
    for (String a in movie.actor) {
      actor.add(a);
    }
    director = movie.director;
    runningTime = movie.runningTime;
    mid = movie.movieId;
    image = movie.postImage;
  }

  static void clearMovieToUpdate() {
    title = null;
    genre = null;
    mid = null;
    type = null;
    startYear = null;
    actor = null;
    director = null;
    runningTime = null;
    gen = null;
    endYear = null;
    image = null;
  }

  static bool isNull() {
    if (title == null ||
        genre == null ||
        type == null ||
        startYear == null ||
        runningTime == null)
      return true;
    else
      return false;
  }
}
