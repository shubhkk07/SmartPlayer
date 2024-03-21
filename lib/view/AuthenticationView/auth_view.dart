import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:smartlisten/view/AuthenticationView/login.dart';
import 'package:smartlisten/view/AuthenticationView/register_user.dart';
import 'package:smartlisten/view/SongView/home.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<AuthenticationBloc, AuthenticationState>(listenWhen: (previous, current) {
              if (current is AuthenticationSuccessful ||
                  previous is AuthenticationSuccessful ||
                  current is AuthenticationErrorState) {
                return true;
              }
              return false;
            }, listener: ((context, state) {
              if (state is AuthenticationSuccessful) {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.success,
                        title: "Success",
                        showCloseIcon: true,
                        animType: AnimType.topSlide,
                        desc: state.message)
                    .show();
              } else if (state is AuthenticationErrorState) {
                AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        title: "Error",
                        showCloseIcon: true,
                        animType: AnimType.topSlide,
                        desc: state.error)
                    .show();
              } else if (state is LoggedInSuccessfully) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ));
              }
            }), builder: ((context, state) {
              if (state is AuthenticationLoginState) {
                return LoginPage();
              } else if (state is AuthenticationRegisterState) {
                return RegisterUser();
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            })),
          ],
        ),
      ),
    );
  }
}
