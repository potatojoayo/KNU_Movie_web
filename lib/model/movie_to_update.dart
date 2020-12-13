class MovieToUpdate {
  static String title;
  static String genre;
  static String type;
  static DateTime startYear;
  static DateTime endYear;
  static List<String> actor;
  static List<String> director;
  static int runningTime;
  static int gen;
  static String image;

  static void clearNewMovie() {
    title = null;
    genre = null;
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
