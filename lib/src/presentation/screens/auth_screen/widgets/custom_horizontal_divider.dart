import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_text.dart';

class CustomHorizontalDivider extends StatelessWidget {
  const CustomHorizontalDivider({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            color: Colors.grey,
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
        CustomText(
          title: title,
          headline: false,
          size: 10.sp,
        ),
        Expanded(
          child: Container(
            color: Colors.grey,
            width: 100,
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ),
      ],
    );
  }
}
