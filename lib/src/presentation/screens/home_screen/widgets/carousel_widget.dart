import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/data/models/favorite_movie_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/config/app_route.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../blocs/favourite/favourite_bloc.dart';
import '../../../../blocs/popular_movies/popular_movies_bloc.dart';
import '../../../../blocs/popular_movies/popular_movies_state.dart';
import 'carousel_item.dart';

class CarouselWidget extends StatelessWidget {
  const CarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMovieBloc, PopularMovieState>(
      builder: (context, state) {
        return CarouselSlider(
            items: state.popularMovies
                .sublist(0, 5)
                .map(
                  (item) => CarouselItem(
                    avatar: item.posterPath,
                    title: item.title,
                    genre: item.genreIds,
                    onTapList: () {
                      String userID =
                          Supabase.instance.client.auth.currentUser!.id;
                      FavoriteMovieModel movie = FavoriteMovieModel(
                        movieID: item.id,
                        posterPath: item.posterPath,
                        title: item.title,
                        overview: item.overview,
                        userID: userID,
                      );
                      getIt<FavouriteBloc>()
                          .add(AddToFavouriteEvent(movie: movie));
                    },
                    onTap: () {
                      context.push(AppRoute.details, extra: item.id);
                    },
                  ),
                )
                .toList(),
            options: CarouselOptions(
              aspectRatio: 1 / 0.8,
              autoPlay: true,
              viewportFraction: 1,
              autoPlayAnimationDuration: const Duration(seconds: 2),
              enlargeCenterPage: false,
            ));
      },
    );
  }
}
