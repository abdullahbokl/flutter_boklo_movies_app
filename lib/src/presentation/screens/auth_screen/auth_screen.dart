import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/app_route.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../blocs/Auth/authentication_bloc.dart';
import 'auth_screen_body.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          GoRouter.of(context).go(AppRoute.homeScreen);
        } else if (state is UnAuthenticatedState) {
          GoRouter.of(context).go(AppRoute.authScreen);
        } else if (state is AuthErrorState) {
          AppConstants.showSnackBar(
            context: context,
            message: 'Something Went Wrong!',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: AbsorbPointer(
            absorbing: state is AuthLoadingState,
            child: const AuthScreenBody(),
          ),
        );
      },
    );
  }
}
