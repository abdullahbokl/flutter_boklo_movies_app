import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../blocs/favourite/favourite_bloc.dart';
import '../../../data/models/favorite_movie_model.dart';
import 'widgets/favorite_card.dart';

class FavouriteScreenBody extends StatelessWidget {
  const FavouriteScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final movies = getIt<FavouriteBloc>().movies;
    if (movies.isEmpty) {
      return SizedBox(
        height: 80.h,
        child: LottieBuilder.asset(
          AppAssets.emptyBoxLottie,
          height: 50.h,
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: movies.length,
        itemBuilder: (BuildContext context, int index) {
          FavoriteMovieModel movie = movies[index];
          return FavoriteCard(
            img: movie.posterPath,
            title: movie.title,
            overview: movie.overview,
            id: movie.movieID,
          );
        },
      );
    }
  }
}
