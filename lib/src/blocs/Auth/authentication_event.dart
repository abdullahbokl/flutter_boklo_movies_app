part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class EmailSignInAuthEvent extends AuthenticationEvent {
  const EmailSignInAuthEvent();

  @override
  List<Object> get props => [];
}

class EmailRegisterAuthEvent extends AuthenticationEvent {
  const EmailRegisterAuthEvent();

  @override
  List<Object> get props => [];
}

class AnonymousAuthEvent extends AuthenticationEvent {
  const AnonymousAuthEvent();
}

class GoogleAuthEvent extends AuthenticationEvent {
  const GoogleAuthEvent();
}

class SignOutEvent extends AuthenticationEvent {
  const SignOutEvent();
}

class SwitchAuthEvent extends AuthenticationEvent {
  const SwitchAuthEvent();
}
