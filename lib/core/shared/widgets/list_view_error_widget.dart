import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../src/presentation/widgets/custom_text.dart';
import '../../utils/app_colors.dart';

class ListViewErrorWidget extends StatelessWidget {
  const ListViewErrorWidget({Key? key, required this.error, required this.func})
      : super(key: key);

  final String error;
  final VoidCallback func;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15.h,
      width: 100.w,
      color: Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: error,
            size: 12,
            color: AppColors.deepBleu,
          ),
          TextButton(
            onPressed: func,
            child: const CustomText(
              title: 'try again !',
              color: AppColors.primary,
              size: 8,
            ),
          ),
        ],
      ),
    );
  }
}
