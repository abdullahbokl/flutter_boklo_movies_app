class FavoriteMovieModel {
  final int movieID;
  final String posterPath;
  final String title;
  final String overview;
  final String userID;

  FavoriteMovieModel({
    required this.movieID,
    required this.posterPath,
    required this.title,
    required this.overview,
    required this.userID,
  });

  factory FavoriteMovieModel.fromMap(Map<String, dynamic> json) {
    return FavoriteMovieModel(
      movieID: json['movie_id'],
      posterPath: json['poster_path'],
      title: json['title'],
      overview: json['overview'],
      userID: json['user_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'movie_id': movieID,
      'poster_path': posterPath,
      'title': title,
      'overview': overview,
      'user_id': userID,
    };
  }
}
