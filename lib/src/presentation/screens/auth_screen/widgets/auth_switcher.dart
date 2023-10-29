import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../blocs/Auth/authentication_bloc.dart';
import '../../../widgets/custom_text.dart';

class AuthSwitcher extends StatelessWidget {
  const AuthSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthenticationBloc>();
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: (authBloc.isLoginScreen)
                  ? "Don't have an account ?"
                  : "You already have an account ?",
              headline: false,
              size: 9,
            ),
            SizedBox(width: 2.w),
            InkWell(
              onTap: () {
                authBloc.add(const SwitchAuthEvent());
              },
              child: Text(
                (authBloc.isLoginScreen) ? 'Sign Up' : 'Log In',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: AppColors.primary,
                      fontSize: 10.sp,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
