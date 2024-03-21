part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

final class AuthenticationLogInView extends AuthenticationEvent {}

final class AuthenticationCreationView extends AuthenticationEvent {}

final class AuthenticationRegisterUser extends AuthenticationEvent {
  final String email, password, name;

  AuthenticationRegisterUser({required this.email, required this.password, required this.name});
}

final class AuthenticationLogInUser extends AuthenticationEvent {
  final String email, password;

  AuthenticationLogInUser({required this.email, required this.password});
}

final class UserLoggedIn extends AuthenticationEvent {}

final class UserLoggedOut extends AuthenticationEvent {}
