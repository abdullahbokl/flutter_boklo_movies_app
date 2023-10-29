import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/service_locator.dart';
import '../../../../../core/utils/validator.dart';
import '../../../../blocs/Auth/authentication_bloc.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_indicator.dart';
import '../../../widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authBloc = getIt<AuthenticationBloc>();
    return Form(
      key: authBloc.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextField(
            isSufix: false,
            hint: 'Enter your Email',
            icon: Icons.email,
            keyboardtype: TextInputType.emailAddress,
            validator: (email) {
              String? error = Validators.validateEmail(email ?? '');
              return error;
            },
            textEditingController: authBloc.emailController,
          ),
          SizedBox(height: 2.h),
          CustomTextField(
            isSufix: false,
            hint: 'Enter your Password',
            icon: Icons.lock,
            keyboardtype: TextInputType.text,
            validator: (value) {
              return value!.length < 6 ? 'Enter a valid Password' : null;
            },
            textEditingController: authBloc.passController,
          ),
          SizedBox(height: 4.h),
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const CustomIndicator();
              } else {
                return CustomButton(
                  func: () {
                    if (authBloc.formKey.currentState!.validate()) {
                      if (authBloc.isLoginScreen) {
                        authBloc.add(const EmailSignInAuthEvent());
                      } else {
                        authBloc.add(
                          const EmailRegisterAuthEvent(),
                        );
                      }
                    }
                  },
                  title: (authBloc.isLoginScreen) ? 'Log In' : 'Sign Up',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
