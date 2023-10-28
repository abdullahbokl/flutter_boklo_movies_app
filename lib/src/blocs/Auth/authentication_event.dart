part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class EmailSignInAuthEvent extends AuthenticationEvent {
  final String email, password;

  const EmailSignInAuthEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class EmailRegisterAuthEvent extends AuthenticationEvent {
  final String email, password;

  const EmailRegisterAuthEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AnounymousAuthEvent extends AuthenticationEvent {
  const AnounymousAuthEvent();
}

class GoogleAuthEvent extends AuthenticationEvent {
  const GoogleAuthEvent();
}

class SignOutEvent extends AuthenticationEvent {
  const SignOutEvent();
}
