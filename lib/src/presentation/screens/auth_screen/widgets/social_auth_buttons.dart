import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../blocs/Auth/authentication_bloc.dart';
import '../../../widgets/custom_indicator.dart';
import 'outlined_button.dart';

class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthenticationBloc>();
    return Column(
      children: [
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is GoogleAuthLoadingState) {
            return const CustomIndicator();
          } else {
            return MyOutlinedButton(
              func: () {
                authBloc.add(const GoogleAuthEvent());
              },
              title: 'Continue with Google',
              img: AppAssets.google,
            );
          }
        }),
        SizedBox(height: 2.h),
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is AuthLoadingState) {
            return const CustomIndicator();
          } else {
            return MyOutlinedButton(
              func: () {
                authBloc.add(const AnonymousAuthEvent());
              },
              title: 'Continue Anonymously',
              img: AppAssets.anonymous,
            );
          }
        }),
      ],
    );
  }
}
