import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../core/utils/service_locator.dart';
import '../popular_movies/popular_movies_bloc.dart';
import '../popular_movies/popular_movies_event.dart';
import '../trending_movies/trending_movies_bloc.dart';
import '../trending_movies/trending_movies_event.dart';
import '../upcoming_movies/upcoming_movies_bloc.dart';
import '../upcoming_movies/upcoming_movies_event.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final ScrollController popularMoviesController = ScrollController();
  final ScrollController recentMoviesController = ScrollController();
  final ScrollController upcomingMoviesController = ScrollController();
  final InternetConnectionChecker _checker = InternetConnectionChecker();
  bool isOnline = false;
  late StreamSubscription<InternetConnectionStatus> listener;

  fetchData() {
    popularMoviesController.addListener(_onPopularMovieScroll);
    recentMoviesController.addListener(_onRecentMovieScroll);
    upcomingMoviesController.addListener(_onUpcomingMovieScroll);
    listener = _checker.onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          isOnline = true;
          break;
        case InternetConnectionStatus.disconnected:
          isOnline = false;
          break;
      }
    });
  }

  void _onPopularMovieScroll() async {
    if (popularMoviesController.position.atEdge) {
      if (popularMoviesController.position.pixels != 0 && isOnline) {
        getIt<PopularMovieBloc>().add(LoadPopularMovieEvent());
      }
    }
  }

  void _onRecentMovieScroll() {
    if (recentMoviesController.position.atEdge) {
      if (recentMoviesController.position.pixels != 0 && isOnline) {
        getIt<TrendingMovieBloc>().add(LoadTrendingMovieEvent());
      }
    }
  }

  void _onUpcomingMovieScroll() {
    if (upcomingMoviesController.position.atEdge) {
      if (upcomingMoviesController.position.pixels != 0 && isOnline) {
        getIt<UpcomingMovieBloc>().add(LoadUpcomingMovieEvent());
      }
    }
  }

  @override
  Future<void> close() {
    popularMoviesController
      ..removeListener(_onPopularMovieScroll)
      ..dispose();
    recentMoviesController
      ..removeListener(_onRecentMovieScroll)
      ..dispose();
    upcomingMoviesController
      ..removeListener(_onUpcomingMovieScroll)
      ..dispose();
    listener.cancel();
    return super.close();
  }
}
