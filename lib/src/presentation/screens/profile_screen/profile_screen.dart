import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/config/app_route.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../blocs/Auth/authentication_bloc.dart';
import '../../../blocs/favourite/favourite_bloc.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Supabase.instance.client.auth.currentUser;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          GoRouter.of(context).pushReplacement(AppRoute.authScreen);
        } else if (state is AuthErrorState) {
          AppConstants.showSnackBar(
            context: context,
            message: 'Something Went Wrong!',
          );
        }
      },
      child: SizedBox(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AppAssets.placeholder,
              height: 20.h,
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomText(
              title:
                  "Welcome\n ${(user?.email == "guest@gmail.com") ? "Anonymous" : user?.email}",
              maxLines: 3,
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomButton(
                func: () {
                  getIt<AuthenticationBloc>().add(const SignOutEvent());
                },
                title: 'Sign Out'),
            SizedBox(
              height: 2.h,
            ),
            (user?.email == "guest@gmail.com")
                ? const SizedBox()
                : CustomButton(
                    color: Colors.red,
                    func: () {
                      getIt<FavouriteBloc>().add(DeleteAllFavouriteEvent());
                    },
                    title: 'Remove all saved data',
                  ),
          ],
        ),
      ),
    );
  }
}
