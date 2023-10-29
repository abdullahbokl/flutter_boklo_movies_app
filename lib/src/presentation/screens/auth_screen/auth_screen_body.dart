import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/config/app_route.dart';
import '../../../../core/shared/widgets/screen_layout.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../blocs/Auth/authentication_bloc.dart';
import '../../widgets/custom_button.dart';
import 'widgets/custom_horizontal_divider.dart';
import 'widgets/social_auth_buttons.dart';
import 'widgets/welcome_message.dart';

class AuthScreenBody extends StatelessWidget {
  const AuthScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return ScreenLayout(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const WelcomeMessage(),
                SizedBox(height: 2.h),
                const SocialAuthButtons(),
                SizedBox(height: 4.h),
                const CustomHorizontalDivider(title: 'OR'),
                SizedBox(height: 4.h),
                CustomButton(
                  func: () {
                    GoRouter.of(context).push(AppRoute.loginScreen);
                  },
                  color: AppColors.primary,
                  title: 'Login with Password',
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
