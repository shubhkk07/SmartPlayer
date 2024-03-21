part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationLoginState extends AuthenticationState {}

final class AuthenticationRegisterState extends AuthenticationState {}

final class AuthenticationLoadingState extends AuthenticationState {}

final class AuthenticationErrorState extends AuthenticationState {
  final String error;

  AuthenticationErrorState({required this.error});
}

final class LoggedInSuccessfully extends AuthenticationState {}

final class AuthenticationSuccessful extends AuthenticationState {
  final String message;

  AuthenticationSuccessful({required this.message});
}
