import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../screen_layout/screen_layout.dart';
import 'widgets/custom_horizontal_divider.dart';
import 'widgets/social_login_buttons.dart';
import 'widgets/welcome_message.dart';

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const WelcomeMessage(),
            SizedBox(height: 2.h),
            const SocialLoginButtons(),
            SizedBox(height: 4.h),
            const CustomHorizontalDivider(),
            SizedBox(
              height: 4.h,
            ),
            CustomButton(
              func: () {
                GoRouter.of(context).push(AppRoute.loginScreen);
              },
              color: AppColors.green,
              title: 'Login with Password',
            )
          ],
        ),
      ),
    );
  }
}
