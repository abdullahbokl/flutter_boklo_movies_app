import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppStrings {
  AppStrings._();

  /* API */
  static final String apiKey = dotenv.env['API_KEY'] ?? '';
  static const String apiBaseUrl = 'https://api.themoviedb.org/3/';
  static const String apiBaseImageUrl = 'https://image.tmdb.org/t/p/w500';

  /* local data source */
  static const String cachedPopularMovies = 'CACHED_CHARACTERS';
  static const String cachedTrendingMovies = 'CACHED_EPISODES';
  static const String cachedUpcomingMovies = 'CACHED_LOCATIONS';
  static const String hiveBox = 'MY_MOVIE_BOX';
}
