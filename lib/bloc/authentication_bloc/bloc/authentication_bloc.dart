import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/main.dart';
import 'package:smartlisten/repository/auth_repo/auth_repo.dart';
import 'package:smartlisten/view/AuthenticationView/auth_view.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final authRepo = AuthRepo();

  AuthenticationBloc() : super(AuthenticationLoginState()) {
    on<AuthenticationCreationView>((event, emit) {
      emit(AuthenticationRegisterState());
    });

    on<AuthenticationLogInView>((event, emit) {
      emit(AuthenticationLoginState());
    });

    on<AuthenticationRegisterUser>((event, emit) async {
      try {
        emit(AuthenticationLoadingState());
        final userData = await authRepo.userRegisteration(email: event.email, password: event.password);
        if (userData != null && userData.user != null) {
          emit(AuthenticationSuccessful(message: "Account created succcessfully. Please Login."));
          emit(AuthenticationLoginState());
        } else {
          emit(AuthenticationErrorState(error: "Something went wrong!"));
          emit(AuthenticationRegisterState());
        }
      } catch (e) {
        emit(AuthenticationErrorState(error: e.toString()));
        emit(AuthenticationRegisterState());
      }
    });

    on<AuthenticationLogInUser>((event, emit) async {
      try {
        emit(AuthenticationLoadingState());
        final userData = await authRepo.signInwithEmailAndPass(email: event.email, password: event.password);
        if (userData != null && userData.user != null) {
          emit(AuthenticationSuccessful(message: "Logged In Successfully."));
          emit(LoggedInSuccessfully());
        } else {
          emit(AuthenticationErrorState(error: "Something went wrong!"));
          emit(AuthenticationLoginState());
        }
      } catch (e) {
        emit(AuthenticationErrorState(error: e.toString()));
        emit(AuthenticationLoginState());
      }
    });

    on<UserLoggedOut>(
      (event, emit) async {
        await authRepo.signOut();
        MyApp.navigatorKey.currentState
            ?.pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthView()), (route) => false);
        AuthenticationLoadingState();
        AuthenticationSuccessful(message: "Logged Out Successfully.");
        emit(AuthenticationLoginState());
      },
    );
  }
}
