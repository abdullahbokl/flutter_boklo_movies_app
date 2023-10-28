import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/utils/app_strings.dart';
import '../data_sources/local/local_data_source.dart';
import '../data_sources/remote/remote_data_source.dart';
import '../models/cast_model.dart';
import '../models/movie_details_model.dart';
import '../models/movie_model.dart';
import '../models/video_model.dart';
import 'movie_repo.dart';

class MoviesRepoImpl implements MoviesRepo {
  final RemoteDataSource remoteDatasource;
  final LocalDataSource localDatasource;
  final InternetConnectionChecker internetConnectionChecker;

  MoviesRepoImpl(
    this.remoteDatasource,
    this.localDatasource,
    this.internetConnectionChecker,
  );

  @override
  Future<List<MovieModel>> getPopular({required int page}) async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        final movies = await remoteDatasource.getPopular(page: page);

        await localDatasource.cache(
            key: AppStrings.cachedPopularMovies, movies: movies, page: page);
        return movies;
      } else {
        final cachedMovies = await localDatasource.get(
            key: AppStrings.cachedPopularMovies, page: page);
        return cachedMovies;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getTrending({required int page}) async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        final movies = await remoteDatasource.getTrending(page: page);

        await localDatasource.cache(
            key: AppStrings.cachedTrendingMovies, movies: movies, page: page);
        return movies;
      } else {
        final cachedMovies = await localDatasource.get(
            key: AppStrings.cachedTrendingMovies, page: page);
        return cachedMovies;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getUpcoming({required int page}) async {
    try {
      if (await internetConnectionChecker.hasConnection) {
        final movies = await remoteDatasource.getUpcoming(page: page);

        await localDatasource.cache(
            key: AppStrings.cachedUpcomingMovies, movies: movies, page: page);
        return movies;
      } else {
        final cachedMovies = await localDatasource.get(
            key: AppStrings.cachedUpcomingMovies, page: page);
        return cachedMovies;
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<MovieModel>> getSearchedMovie({required String query}) async {
    try {
      final movies = await remoteDatasource.getSearchedMovie(query: query);
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<MovieDetailsModel> getMovieDetails({required int id}) async {
    print("id $id");
    try {
      final movies = await remoteDatasource.getMovieDetails(id: id);
      print("movies $movies");
      return movies;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> getImages({required int id}) async {
    try {
      final images = await remoteDatasource.getImages(id: id);
      return images;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<CastCrewModel>> getCastCrew({required int id}) async {
    try {
      final cast = await remoteDatasource.getCastCrew(id: id);
      return cast;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> getVideo({required int id}) async {
    try {
      final videos = await remoteDatasource.getVideo(id: id);
      return videos;
    } catch (_) {
      rethrow;
    }
  }
}
