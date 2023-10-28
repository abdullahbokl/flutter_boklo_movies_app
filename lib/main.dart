import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/src/blocs/home/home_cubit.dart';
import 'package:nested/nested.dart';

import 'core/config/app_setup.dart';
import 'core/utils/service_locator.dart';
import 'movies_finder.dart';
import 'src/blocs/Auth/authentication_bloc.dart';
import 'src/blocs/favourite/favourite_bloc.dart';
import 'src/blocs/movie_cast/movie_cast_bloc.dart';
import 'src/blocs/movie_details/movie_details_bloc.dart';
import 'src/blocs/movie_images/movie_images_bloc.dart';
import 'src/blocs/movie_video/movie_video_bloc.dart';
import 'src/blocs/popular_movies/popular_movies_bloc.dart';
import 'src/blocs/popular_movies/popular_movies_event.dart';
import 'src/blocs/search_movies/search_movie_bloc.dart';
import 'src/blocs/trending_movies/trending_movies_bloc.dart';
import 'src/blocs/trending_movies/trending_movies_event.dart';
import 'src/blocs/upcoming_movies/upcoming_movies_bloc.dart';
import 'src/blocs/upcoming_movies/upcoming_movies_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppSetup.initApp();

  runApp(
    MultiBlocProvider(
      providers: _providers(),
      child: const MovieFinder(),
    ),
  );
}

List<SingleChildWidget> _providers() {
  return [
    BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc(getIt()),
    ),
    BlocProvider<HomeCubit>(
      create: (_) => HomeCubit()..fetchData(),
    ),
    BlocProvider<PopularMovieBloc>(
      create: (_) => getIt<PopularMovieBloc>()..add(LoadPopularMovieEvent()),
    ),
    BlocProvider<TrendingMovieBloc>(
      create: (_) => getIt<TrendingMovieBloc>()..add(LoadTrendingMovieEvent()),
    ),
    BlocProvider<UpcomingMovieBloc>(
      create: (_) => getIt<UpcomingMovieBloc>()..add(LoadUpcomingMovieEvent()),
    ),
    BlocProvider<SearchMoviesBloc>(
      create: (_) => getIt<SearchMoviesBloc>(),
    ),
    BlocProvider<MovieDetailsBloc>(
      create: (_) => getIt<MovieDetailsBloc>(),
    ),
    BlocProvider<FavouriteBloc>(
      create: (_) => getIt<FavouriteBloc>()..add(GetFavouriteMoviesEvent()),
    ),
    BlocProvider<MovieImagesBloc>(
      create: (_) => getIt<MovieImagesBloc>(),
    ),
    BlocProvider<MovieCastBloc>(
      create: (_) => getIt<MovieCastBloc>(),
    ),
    BlocProvider<MovieVideoBloc>(
      create: (_) => getIt<MovieVideoBloc>(),
    ),
  ];
}
