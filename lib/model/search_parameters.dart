class SearchParameters {
  static String title;
  static String genre;
  static String type;
  static int minStartYear;
  static int maxStartYear;
  static String actor;
  static String director;
  static int minRating;
  static int maxRating;
  static int uid;

  static void clearParams() {
    uid = null;
    title = null;
    genre = null;
    type = null;
    minStartYear = null;
    maxStartYear = null;
    actor = null;
    director = null;
    minRating = null;
    maxRating = null;
  }
}
