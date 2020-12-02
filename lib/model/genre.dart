class Genre {
  Genre({this.genre, this.gen});
  final genre;
  final gen;

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(genre: json['genre'] as String, gen: json['genre_id'] as int);
  }
}
