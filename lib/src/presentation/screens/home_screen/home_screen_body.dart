import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'widgets/carousel_widget.dart';
import 'widgets/popular_movies_list.dart';
import 'widgets/trending_movies_list.dart';
import 'widgets/upcoming_movies_list.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const CarouselWidget(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                const PopularMoviesList(),
                SizedBox(height: 2.h),
                const TrendingMoviesList(),
                SizedBox(height: 2.h),
                const UpcomingMoviesList(),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
