import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:smartlisten/constants/custom_button.dart';
import 'package:smartlisten/view/AuthenticationView/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Login",
          textScaler: TextScaler.noScaling,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(
                1.0,
                1.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 7.0,
            ),
            const BoxShadow(color: Colors.white, spreadRadius: 0),
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomTextField(
                textEditingController: emailController,
                labelTitle: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                textEditingController: passwordController,
                labelTitle: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Icons.lock_outline_rounded,
                obscureText: true,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  callback: () {
                    FocusScope.of(context).unfocus();
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogInUser(email: emailController.text, password: passwordController.text));
                  },
                  title: "Login"),
              const SizedBox(
                height: 10,
              ),
              RichText(
                  text: TextSpan(children: [
                const TextSpan(text: "Don't have account!", style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: " Sign Up ",
                    style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.read<AuthenticationBloc>().add(AuthenticationCreationView());
                      })
              ]))
            ],
          ),
        ),
      ],
    );
  }
}
