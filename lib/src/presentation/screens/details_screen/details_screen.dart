import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../blocs/movie_cast/movie_cast_bloc.dart';
import '../../../blocs/movie_details/movie_details_bloc.dart';
import '../../../blocs/movie_images/movie_images_bloc.dart';
import '../../../blocs/movie_video/movie_video_bloc.dart';
import '../../widgets/custom_error_widget.dart';
import 'details_screen_body.dart';

class DetailsScreen extends StatefulWidget {
  final int id;

  const DetailsScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  void initState() {
    context.read<MovieDetailsBloc>().add(LoadMovieDetails(widget.id));
    context.read<MovieImagesBloc>().add(LoadMovieImages(widget.id));
    context.read<MovieCastBloc>().add(LoadMovieCast(widget.id));
    context.read<MovieVideoBloc>().add(LoadMovieVideo(widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
        builder: (context, movieState) {
          if (movieState is MovieDetailsLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.primary,
            ));
          } else if (movieState is MovieDetailsSuccess) {
            return DetailsScreenBody(movie: movieState.movie);
          } else if (movieState is MovieDetailsError) {
            return CustomErrorWidget(
              error: movieState.error,
              func: () {
                context
                    .read<MovieDetailsBloc>()
                    .add(LoadMovieDetails(widget.id));
                context.read<MovieImagesBloc>().add(LoadMovieImages(widget.id));
                context.read<MovieCastBloc>().add(LoadMovieCast(widget.id));
                context.read<MovieVideoBloc>().add(LoadMovieVideo(widget.id));
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
