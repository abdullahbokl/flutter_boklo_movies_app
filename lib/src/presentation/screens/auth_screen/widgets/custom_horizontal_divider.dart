import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_text.dart';

class CustomHorizontalDivider extends StatelessWidget {
  const CustomHorizontalDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.grey,
          width: 100,
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 20),
        ),
        CustomText(
          title: 'Or',
          headline: false,
          size: 10.sp,
        ),
        Container(
          color: Colors.grey,
          width: 100,
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 20),
        ),
      ],
    );
  }
}
