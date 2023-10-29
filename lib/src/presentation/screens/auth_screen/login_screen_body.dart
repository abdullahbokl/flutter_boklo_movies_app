import 'package:flutter/material.dart';
import 'package:movie_finder/src/presentation/screens/auth_screen/widgets/auth_switcher.dart';
import 'package:movie_finder/src/presentation/screens/auth_screen/widgets/custom_horizontal_divider.dart';
import 'package:movie_finder/src/presentation/screens/auth_screen/widgets/social_buttons_row.dart';
import 'package:sizer/sizer.dart';

import 'widgets/auth_logo.dart';
import 'widgets/login_form.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const AuthLogo(),
        SizedBox(height: 7.h),
        const LoginForm(),
        SizedBox(height: 2.h),
        const AuthSwitcher(),
        SizedBox(height: 3.h),
        const CustomHorizontalDivider(title: 'Or Continue with'),
        SizedBox(height: 4.h),
        const SocialButtonsRow(),
      ],
    );
  }
}
