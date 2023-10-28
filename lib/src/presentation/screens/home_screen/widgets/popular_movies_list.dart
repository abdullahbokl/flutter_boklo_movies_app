import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/shared/widgets/list_view_error_widget.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../blocs/home/home_cubit.dart';
import '../../../../blocs/popular_movies/popular_movies_bloc.dart';
import '../../../../blocs/popular_movies/popular_movies_event.dart';
import '../../../../blocs/popular_movies/popular_movies_state.dart';
import '../../../widgets/custom_text.dart';
import 'movie_listview.dart';

class PopularMoviesList extends StatelessWidget {
  const PopularMoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeCubit homeCubit = context.read<HomeCubit>();
    final PopularMovieBloc popularMovieBloc = getIt<PopularMovieBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          title: 'Popular Movies',
          size: 12,
        ),
        SizedBox(height: 2.h),
        BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
            switch (state.status) {
              case PopularMovieStatus.initial:
                return SizedBox(height: 25.h);

              case PopularMovieStatus.success:
                return MoviesListView(
                  controller: homeCubit.popularMoviesController,
                  movies: state.popularMovies,
                  hasReachedMax: state.hasReachedMax,
                );

              case PopularMovieStatus.failure:
                return ListViewErrorWidget(
                  error: state.error,
                  func: () {
                    popularMovieBloc.add(LoadPopularMovieEvent());
                  },
                );
            }
          },
        ),
      ],
    );
  }
}
