import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/blocs/favourite/favourite_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../../core/config/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../blocs/movie_video/movie_video_bloc.dart';
import '../../../../data/models/favorite_movie_model.dart';
import '../../../../data/models/movie_details_model.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import 'favorite_button.dart';

class CustomFlexibleSpaceBar extends StatefulWidget {
  final MovieDetailsModel movie;

  const CustomFlexibleSpaceBar({Key? key, required this.movie})
      : super(key: key);

  @override
  CustomFlexibleSpaceBarState createState() {
    return CustomFlexibleSpaceBarState();
  }
}

class CustomFlexibleSpaceBarState extends State<CustomFlexibleSpaceBar> {
  ScrollPosition? _position;
  bool? _visible;

  @override
  void dispose() {
    _removeListener();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _removeListener();
    _addListener();
  }

  void _addListener() {
    _position = Scrollable.of(context).position;
    _position?.addListener(_positionListener);
    _positionListener();
  }

  void _removeListener() {
    _position?.removeListener(_positionListener);
  }

  void _positionListener() {
    final FlexibleSpaceBarSettings? settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    bool visible =
        settings == null || settings.currentExtent <= settings.minExtent;
    if (_visible != visible) {
      setState(() {
        _visible = visible;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavouriteBloc, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteChanged) {
          AppConstants.showSnackBar(
            context: context,
            message: 'Movie Saved Successfully',
            color: AppColors.green,
          );
        } else if (state is FavouriteError) {
          AppConstants.showSnackBar(
            context: context,
            message: state.message,
            color: Colors.red,
          );
        }
      },
      child: FlexibleSpaceBar(
        centerTitle: true,
        expandedTitleScale: 1,
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl:
                  '${AppStrings.apiBaseImageUrl}${widget.movie.backdropPath}',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
                  Theme.of(context).scaffoldBackgroundColor,
                ],
              )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(
                  title: widget.movie.title,
                  maxLines: 4,
                  horizontalPadding: 20,
                ),
                SizedBox(height: 2.h),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      widget.movie.genres.length,
                      (index) => CustomText(
                        title: widget.movie.genres[index].name +
                            (index + 1 < widget.movie.genres.length
                                ? '  |  '
                                : ''),
                        color: Colors.grey,
                        size: 8,
                      ),
                    )),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: List.generate(
                          widget.movie.voteAverage.toInt() + 1,
                          (index) => Icon(
                                index == widget.movie.voteAverage.toInt()
                                    ? Icons.star_half
                                    : Icons.star,
                                color: Colors.amber,
                                size: 15.sp,
                              )),
                    ),
                    SizedBox(width: 1.w),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: CustomText(
                        title: widget.movie.voteAverage.toStringAsFixed(1),
                        size: 8,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildColumnInfo(
                      title: 'Year',
                      content: widget.movie.releaseDate.split('-')[0],
                    ),
                    SizedBox(width: 4.w),
                    _buildColumnInfo(
                      title: 'Revenue',
                      content:
                          '${(widget.movie.revenue / 1000000).toStringAsFixed(1)} M',
                    ),
                    SizedBox(width: 4.w),
                    _buildColumnInfo(
                      title: 'Length',
                      content: '${widget.movie.runtime.toString()} min',
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                BlocBuilder<MovieVideoBloc, MovieVideoState>(
                  builder: (context, state) {
                    if (state is MovieVideoSuccess) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 70.w,
                            child: CustomButton(
                              func: () {
                                context.push(AppRoute.trailer,
                                    extra: state.videos);
                              },
                              title: 'Play Trailer',
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          CustomFavouriteButton(
                            func: () {
                              User? user =
                                  Supabase.instance.client.auth.currentUser;
                              FavoriteMovieModel movie = FavoriteMovieModel(
                                movieID: widget.movie.id,
                                posterPath: widget.movie.posterPath,
                                title: widget.movie.title,
                                overview: widget.movie.overview,
                                userID: user!.id,
                              );
                              if (user.email != 'guest@gmail.com') {
                                getIt<FavouriteBloc>()
                                    .add(AddToFavouriteEvent(movie: movie));
                              } else {
                                AppConstants.showSnackBar(
                                  context: context,
                                  message:
                                      "Sorry, but you can't save movies as an anonymous user !\n--> Please Log In with your email so you can save movies.",
                                  color: Colors.red,
                                );
                              }
                            },
                          )
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            )
          ],
        ),
        title: Visibility(
          visible: (_visible ?? false),
          child: const CustomText(
            title: 'Movie Finder',
            color: AppColors.green,
          ),
        ),
      ),
    );
  }

  Column _buildColumnInfo({required String title, required String content}) {
    return Column(
      children: [
        CustomText(
          title: title,
          color: Colors.grey,
          size: 8,
        ),
        SizedBox(
          height: 1.h,
        ),
        CustomText(
          title: content,
          size: 10,
        ),
      ],
    );
  }
}
