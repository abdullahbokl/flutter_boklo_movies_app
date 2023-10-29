import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/shared/widgets/screen_layout.dart';
import '../../../../core/utils/service_locator.dart';
import '../../../blocs/Auth/authentication_bloc.dart';
import 'login_screen_body.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final authBloc = getIt<AuthenticationBloc>();

  @override
  void initState() {
    authBloc.animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..forward();

    authBloc.rotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: authBloc.animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 100.h,
          child: const LoginScreenBody(),
        ),
      ),
    );
  }
}
