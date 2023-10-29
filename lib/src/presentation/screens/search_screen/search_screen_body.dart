import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../blocs/search_movies/search_movie_bloc.dart';
import '../../widgets/custom_indicator.dart';
import 'widgets/search_error_widget.dart';
import 'widgets/search_results_list.dart';

class SearchScreenBody extends StatelessWidget {
  const SearchScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final searchBloc = getIt<SearchMoviesBloc>();

    return BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
        builder: (context, state) {
      if (state is SearchLoadingState) {
        return SizedBox(
          height: 80.h,
          child: const CustomIndicator(),
        );
      } else if (state is SearchErrorState) {
        return SearchErrorWidget(
          error: state.message,
          lottieAnimation: AppAssets.errorLottie,
        );
      } else if (state is SearchSuccessState) {
        if (searchBloc.movies.isEmpty) {
          return const SearchErrorWidget(
            error: 'No Movie Found !',
            lottieAnimation: AppAssets.emptyBoxLottie,
          );
        }

        return SearchResultsList(movies: searchBloc.movies);
      }

      return const SizedBox.shrink();
    });
  }
}
