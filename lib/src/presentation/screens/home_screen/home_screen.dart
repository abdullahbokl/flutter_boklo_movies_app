import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/popular_movies/popular_movies_bloc.dart';
import '../../../blocs/popular_movies/popular_movies_event.dart';
import '../../../blocs/popular_movies/popular_movies_state.dart';
import '../../../blocs/trending_movies/trending_movies_bloc.dart';
import '../../../blocs/trending_movies/trending_movies_event.dart';
import '../../../blocs/upcoming_movies/upcoming_movies_bloc.dart';
import '../../../blocs/upcoming_movies/upcoming_movies_event.dart';
import '../../widgets/custom_error_widget.dart';
import 'home_screen_body.dart';
import 'widgets/shimmer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
        switch (state.status) {
          case PopularMovieStatus.initial:
            return const ShimmerWidget();

          case PopularMovieStatus.success:
            return const HomeScreenBody();

          case PopularMovieStatus.failure:
            return CustomErrorWidget(
              error: state.error,
              func: () {
                context.read<PopularMovieBloc>().add(LoadPopularMovieEvent());
                context.read<TrendingMovieBloc>().add(LoadTrendingMovieEvent());
                context.read<UpcomingMovieBloc>().add(LoadUpcomingMovieEvent());
              },
            );
        }
      }),
    );
  }
}
