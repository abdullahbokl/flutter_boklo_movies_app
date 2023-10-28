import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/shared/widgets/list_view_error_widget.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../blocs/home/home_cubit.dart';
import '../../../../blocs/upcoming_movies/upcoming_movies_bloc.dart';
import '../../../../blocs/upcoming_movies/upcoming_movies_event.dart';
import '../../../../blocs/upcoming_movies/upcoming_movies_state.dart';
import '../../../widgets/custom_text.dart';
import 'movie_listview.dart';

class UpcomingMoviesList extends StatelessWidget {
  const UpcomingMoviesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    final upcomingMovieBloc = getIt<UpcomingMovieBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          title: 'Upcoming Movies',
          size: 12,
        ),
        SizedBox(height: 2.h),
        BlocBuilder<UpcomingMovieBloc, UpcomingMovieState>(
          builder: (context, state) {
            switch (state.status) {
              case UpcomingMovieStatus.initial:
                return SizedBox(height: 25.h);

              case UpcomingMovieStatus.success:
                return MoviesListView(
                  controller: homeCubit.upcomingMoviesController,
                  movies: state.upcomingMovies,
                  hasReachedMax: state.hasReachedMax,
                );

              case UpcomingMovieStatus.failure:
                return ListViewErrorWidget(
                  error: state.error,
                  func: () {
                    upcomingMovieBloc.add(LoadUpcomingMovieEvent());
                  },
                );
            }
          },
        ),
      ],
    );
  }
}
