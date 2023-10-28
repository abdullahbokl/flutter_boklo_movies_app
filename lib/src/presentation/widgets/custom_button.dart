import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final void Function() func;
  final Color color;
  final String title;
  final double fontSize;
  final OutlinedBorder shape;

  const CustomButton({
    Key? key,
    required this.func,
    required this.title,
    this.fontSize = 12,
    this.color = AppColors.green,
    this.shape = const StadiumBorder(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: func,
      style: ElevatedButton.styleFrom(
          shape: shape,
          backgroundColor: color,
          elevation: 10,
          minimumSize: Size(
            80.w,
            7.h,
          )
          // padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 4.w),
          ),
      child: CustomText(
        title: title,
        headline: false,
        size: fontSize,
        color: Colors.white,
      ),
    );
  }
}
