import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/movie_details_model.dart';
import '../../widgets/custom_text.dart';
import 'widgets/back_button.dart';
import 'widgets/cast_widget.dart';
import 'widgets/custom_flexible_spacebar.dart';
import 'widgets/screenshot_widget.dart';

class DetailsScreenBody extends StatelessWidget {
  const DetailsScreenBody({Key? key, required this.movie}) : super(key: key);

  final MovieDetailsModel movie;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: const CustomBackButton(),
          flexibleSpace: CustomFlexibleSpaceBar(movie: movie),
          expandedHeight: 65.h,
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  maxLines: 15,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Overview : ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.amber,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w900,
                        ),
                    children: [
                      TextSpan(
                        text: movie.overview,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(fontSize: 10.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2.h),
                const CustomText(
                  title: 'Cast ',
                  size: 12,
                ),
                const CastWidget(),
                const CustomText(
                  title: 'Screenshots ',
                  size: 12,
                ),
                const ScreenshotWidget(),
                SizedBox(height: 2.h),
                SizedBox(height: 5.h),
              ],
            ),
          ),
        ])),
      ],
    );
  }
}
