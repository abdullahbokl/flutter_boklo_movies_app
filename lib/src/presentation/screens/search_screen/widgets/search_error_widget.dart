import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_text.dart';

class SearchErrorWidget extends StatelessWidget {
  const SearchErrorWidget({
    Key? key,
    required this.error,
    required this.lottieAnimation,
  }) : super(key: key);

  final String error;
  final String lottieAnimation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(title: error),
          SizedBox(
            height: 2.h,
          ),
          LottieBuilder.asset(
            lottieAnimation,
            height: 50.h,
          ),
        ],
      ),
    );
  }
}
