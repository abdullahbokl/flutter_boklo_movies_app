import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/config/app_route.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../widgets/custom_text.dart';

class MovieCard extends StatelessWidget {
  final String imageUrl;
  final double rate;
  final int id;

  const MovieCard({
    required this.imageUrl,
    required this.rate,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoute.details, extra: id);
      },
      child: CachedNetworkImage(
        imageUrl: '${AppStrings.apiBaseImageUrl}$imageUrl',
        errorWidget: (context, url, error) {
          return AspectRatio(
            aspectRatio: 2.2 / 3,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey, Colors.grey.shade100],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                  child: CustomText(
                title: 'No Image Found !',
                size: 8,
              )),
            ),
          );
        },
        imageBuilder: (context, imageProvider) {
          return Stack(
            children: [
              AspectRatio(
                aspectRatio: 2.2 / 3,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 15,
                top: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primary,
                  ),
                  child: CustomText(
                    title: rate.toString(),
                    size: 10,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
