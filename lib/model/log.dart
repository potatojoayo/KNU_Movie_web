class Log {
  Log(
      {this.movieId,
      this.originalTitle,
      this.datePart,
      this.rating = 0,
      this.postImage,
      this.email});

  final int movieId;
  final String originalTitle;
  final int datePart;
  final int rating;
  final String postImage;
  final String email;

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
        movieId: json['movie_id'] as int,
        originalTitle: json['original_title'] as String,
        email: json['email_add'] as String,
        datePart: json['date_part'] as int,
        rating: json['single_rating'] as int,
        postImage: json['post_image'] as String);
  }
}
