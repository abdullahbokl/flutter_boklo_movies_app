import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/auth_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoginScreen = true;
  late AnimationController animationController;
  late Animation<double> rotationAnimation;

  AuthenticationBloc(this._authService) : super(AuthenticationInitial()) {
    on<EmailRegisterAuthEvent>((event, emit) async {
      await _emailRegisterAuth(emit, event);
    });

    on<EmailSignInAuthEvent>(
      (event, emit) async {
        await _emailSignInAuth(emit, event);
      },
    );

    on<AnonymousAuthEvent>((event, emit) async {
      await _anonymousAuth(emit);
    });

    on<GoogleAuthEvent>((event, emit) async {
      await _googleAuth(emit);
    });

    on<SignOutEvent>((event, emit) async {
      await _signOut(emit);
    });

    on<SwitchAuthEvent>((event, emit) async {
      _switchAuth(emit);
    });
  }

  Future<void> _emailRegisterAuth(
    Emitter<AuthenticationState> emit,
    EmailRegisterAuthEvent event,
  ) async {
    emit(AuthLoadingState());
    try {
      await _authService.signUpWithEmail(
        email: emailController.text,
        password: passController.text,
      );
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _emailSignInAuth(
    Emitter<AuthenticationState> emit,
    EmailSignInAuthEvent event,
  ) async {
    emit(AuthLoadingState());
    try {
      await _authService.signInWithEmail(
        email: emailController.text,
        password: passController.text,
      );
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _anonymousAuth(Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    try {
      await _authService.anonymousSignIn();
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _googleAuth(Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    try {
      await _authService.signInWithGoogle();
      emit(AuthSuccessState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  Future<void> _signOut(Emitter<AuthenticationState> emit) async {
    emit(AuthLoadingState());
    try {
      await _authService.signOut();
      emit(UnAuthenticatedState());
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  void _switchAuth(Emitter<AuthenticationState> emit) {
    emit(AuthLoadingState());
    isLoginScreen = !isLoginScreen;
    animationController
      ..reset()
      ..forward();
    emit(SwitchAuthState());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passController.dispose();
    return super.close();
  }
}
