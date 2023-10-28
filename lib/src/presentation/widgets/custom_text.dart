import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomText extends StatelessWidget {
  final bool headline;
  final String title;
  final double size;
  final double horizontalPadding;
  final TextAlign textAlign;
  final int maxLines;
  final Color? color;

  const CustomText({
    Key? key,
    required this.title,
    this.size = 15,
    this.headline = true,
    this.horizontalPadding = 0,
    this.maxLines = 1,
    this.color,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
      child: Text(
        title,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        style: (headline)
            ? Theme.of(context).textTheme.displayLarge!.copyWith(
                  fontSize: size.sp,
                  color:
                      color ?? Theme.of(context).textTheme.displayLarge!.color,
                  height: 1.5,
                )
            : Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: size.sp,
                  color:
                      color ?? Theme.of(context).textTheme.titleMedium!.color,
                ),
      ),
    );
  }
}
