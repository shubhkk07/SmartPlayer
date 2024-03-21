import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartlisten/bloc/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:smartlisten/constants/custom_button.dart';
import 'package:smartlisten/view/AuthenticationView/custom_text_field.dart';

class RegisterUser extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  RegisterUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Register",
          textScaler: TextScaler.noScaling,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        CustomTextField(
            textEditingController: nameController,
            labelTitle: "Name",
            hintText: "Enter your name",
            prefixIcon: Icons.person_2_outlined),
        const SizedBox(
          height: 20,
        ),
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
              context.read<AuthenticationBloc>().add(AuthenticationRegisterUser(
                  email: emailController.text, password: passwordController.text, name: nameController.text));
            },
            title: "Register"),
        const SizedBox(
          height: 10,
        ),
        Align(
          alignment: Alignment.center,
          child: RichText(
              text: TextSpan(children: [
            const TextSpan(text: "Already have account.", style: TextStyle(color: Colors.black)),
            TextSpan(
                text: " Log In ",
                style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    context.read<AuthenticationBloc>().add(AuthenticationLogInView());
                  })
          ])),
        )
      ],
    );
  }
}
