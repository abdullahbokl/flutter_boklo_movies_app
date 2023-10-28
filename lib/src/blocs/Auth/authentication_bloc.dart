import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/auth_service.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _authService;

  AuthenticationBloc(this._authService) : super(AuthenticationInitial()) {
    on<EmailRegisterAuthEvent>((event, emit) async {
      return await _emailRegisterAuth(emit, event);
    });

    on<EmailSignInAuthEvent>(
      (event, emit) async {
        return await _emailSignInAuth(emit, event);
      },
    );

    on<AnounymousAuthEvent>((event, emit) async {
      return await _anonymousAuth(emit);
    });

    on<GoogleAuthEvent>((event, emit) async {
      return await _googleAuth(emit);
    });

    on<SignOutEvent>((event, emit) async {
      return await _signOut(emit);
    });
  }

  Future<void> _emailRegisterAuth(
    Emitter<AuthenticationState> emit,
    EmailRegisterAuthEvent event,
  ) async {
    emit(AuthLoadingState());
    try {
      await _authService.signUpWithEmail(
        email: event.email,
        password: event.password,
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
        email: event.email,
        password: event.password,
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
}
