import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/app_assets.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback func;

  const CustomErrorWidget({
    Key? key,
    required this.error,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            title: error,
            horizontalPadding: 10,
            maxLines: 2,
          ),
          SizedBox(height: 4.h),
          Lottie.asset(AppAssets.errorLottie),
          SizedBox(height: 4.h),
          CustomButton(func: func, title: 'Try Again !')
        ],
      ),
    );
  }
}
