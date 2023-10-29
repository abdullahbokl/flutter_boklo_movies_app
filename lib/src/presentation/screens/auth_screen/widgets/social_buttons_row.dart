import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/service_locator.dart';
import '../../../../blocs/Auth/authentication_bloc.dart';
import 'social_card_button.dart';

class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthenticationBloc>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialCardButton(
          img: AppAssets.facebook,
          func: () {
            AppConstants.showSnackBar(
              context: context,
              message: 'Coming Soon !',
              color: Colors.grey,
            );
          },
        ),
        SizedBox(width: 4.w),
        SocialCardButton(
          img: AppAssets.google,
          func: () {
            authBloc.add(const GoogleAuthEvent());
          },
        ),
        SizedBox(width: 4.w),
        SocialCardButton(
          img: AppAssets.anonymous,
          func: () {
            authBloc.add(const AnonymousAuthEvent());
          },
        ),
      ],
    );
  }
}
