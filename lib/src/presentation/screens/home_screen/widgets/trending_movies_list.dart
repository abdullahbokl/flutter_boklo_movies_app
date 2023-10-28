import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/shared/widgets/list_view_error_widget.dart';
import '../../../../blocs/home/home_cubit.dart';
import '../../../../blocs/trending_movies/trending_movies_bloc.dart';
import '../../../../blocs/trending_movies/trending_movies_event.dart';
import '../../../../blocs/trending_movies/trending_movies_state.dart';
import '../../../widgets/custom_text.dart';
import 'movie_listview.dart';

class TrendingMoviesList extends StatelessWidget {
  const TrendingMoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    final TrendingMovieBloc trendingMovieBloc =
        context.read<TrendingMovieBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          title: 'Trending Movies',
          size: 12,
        ),
        SizedBox(
          height: 2.h,
        ),
        BlocBuilder<TrendingMovieBloc, TrendingMovieState>(
          builder: (context, state) {
            switch (state.status) {
              case TrendingMovieStatus.initial:
                return SizedBox(height: 25.h);

              case TrendingMovieStatus.success:
                return MoviesListView(
                  controller: homeCubit.recentMoviesController,
                  movies: state.trendingMovies,
                  hasReachedMax: state.hasReachedMax,
                );

              case TrendingMovieStatus.failure:
                return ListViewErrorWidget(
                  error: state.error,
                  func: () {
                    trendingMovieBloc.add(LoadTrendingMovieEvent());
                  },
                );
            }
          },
        ),
      ],
    );
  }
}
