import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function callback;
  final String title;
  const CustomButton({super.key, required this.callback, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 10)),
            elevation: MaterialStateProperty.all(5),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            fixedSize: MaterialStateProperty.all(Size.fromWidth(MediaQuery.of(context).size.width))),
        onPressed: () => callback(),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
        ));
  }
}
