import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../widgets/custom_text.dart';
import 'outlined_button.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedSize(
          duration: const Duration(seconds: 1),
          child: Image.asset(
            AppAssets.loginImage,
            height: 30.h,
            fit: BoxFit.cover,
          ),
        ),
        const CustomText(
          title: 'Welcome, Shall We Begin ?',
          headline: true,
        ),
        SizedBox(height: 6.h),
        MyOutlinedButton(
          func: () {
            AppConstants.showSnackBar(
              context: context,
              message: 'Coming Soon !',
              color: Colors.grey,
            );
          },
          title: 'Continue with Google',
          img: AppAssets.facebook,
        ),
      ],
    );
  }
}
