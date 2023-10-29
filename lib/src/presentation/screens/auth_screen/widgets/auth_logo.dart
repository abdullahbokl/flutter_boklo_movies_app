import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../blocs/Auth/authentication_bloc.dart';
import '../../../widgets/custom_text.dart';

class AuthLogo extends StatelessWidget {
  const AuthLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthenticationBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RotationTransition(
          turns: authBloc.rotationAnimation,
          child: Image.asset(
            AppAssets.appIcon,
            height: 15.h,
          ),
        ),
        SizedBox(height: 4.h),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            return CustomText(
              title: (authBloc.isLoginScreen)
                  ? 'Login to Your Account'
                  : 'Create Your Account',
              size: 17,
            );
          },
        ),
      ],
    );
  }
}
