import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:movie_finder/src/blocs/Auth/authentication_bloc.dart';

import '../../src/blocs/favourite/favourite_bloc.dart';
import '../../src/blocs/movie_cast/movie_cast_bloc.dart';
import '../../src/blocs/movie_details/movie_details_bloc.dart';
import '../../src/blocs/movie_images/movie_images_bloc.dart';
import '../../src/blocs/movie_video/movie_video_bloc.dart';
import '../../src/blocs/popular_movies/popular_movies_bloc.dart';
import '../../src/blocs/search_movies/search_movie_bloc.dart';
import '../../src/blocs/trending_movies/trending_movies_bloc.dart';
import '../../src/blocs/upcoming_movies/upcoming_movies_bloc.dart';
import '../../src/data/data_sources/local/local_data_source.dart';
import '../../src/data/data_sources/local/local_data_source_impl.dart';
import '../../src/data/data_sources/remote/remote_data_source.dart';
import '../../src/data/data_sources/remote/remote_data_source_impl.dart';
import '../../src/data/repositories/movie_repo.dart';
import '../../src/data/repositories/movie_repo_impl.dart';
import '../services/api_services.dart';
import '../services/auth_service.dart';
import 'app_strings.dart';

final getIt = GetIt.I;

Future setupServiceLocator() async {
  final networkInfo = InternetConnectionChecker();

  /* Dio */
  getIt.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(
      baseUrl: AppStrings.apiBaseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      receiveDataWhenStatusError: true,
      contentType: "application/json",
      queryParameters: {
        "api_key": AppStrings.apiKey,
      },
    )),
  );

/* Services */
  getIt.registerLazySingleton<ApiServices>(() => ApiServices(getIt<Dio>()));
  getIt.registerLazySingleton<AuthService>(() => AuthService());

/* Data Sources */
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(getIt()));

  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

/* Repositories */
  getIt.registerLazySingleton<MoviesRepo>(() => MoviesRepoImpl(
        getIt(),
        getIt(),
        networkInfo,
      ));

/* BLOCs */
  getIt.registerLazySingleton<AuthenticationBloc>(
      () => AuthenticationBloc(getIt()));
  getIt
      .registerLazySingleton<PopularMovieBloc>(() => PopularMovieBloc(getIt()));
  getIt.registerLazySingleton<TrendingMovieBloc>(
      () => TrendingMovieBloc(getIt()));
  getIt.registerLazySingleton<UpcomingMovieBloc>(
      () => UpcomingMovieBloc(getIt()));
  getIt
      .registerLazySingleton<SearchMoviesBloc>(() => SearchMoviesBloc(getIt()));
  getIt
      .registerLazySingleton<MovieDetailsBloc>(() => MovieDetailsBloc(getIt()));
  getIt.registerLazySingleton<MovieImagesBloc>(() => MovieImagesBloc(getIt()));
  getIt.registerLazySingleton<MovieCastBloc>(() => MovieCastBloc(getIt()));
  getIt.registerLazySingleton<MovieVideoBloc>(() => MovieVideoBloc(getIt()));
  getIt.registerLazySingleton<FavouriteBloc>(() => FavouriteBloc());
}
