import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelTitle, hintText;
  final TextEditingController textEditingController;
  final IconData prefixIcon;
  final bool? obscureText;
  const CustomTextField(
      {super.key,
      required this.labelTitle,
      required this.hintText,
      required this.prefixIcon,
      this.obscureText,
      required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          obscureText: obscureText ?? false,
          controller: textEditingController,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.4)),
              prefixIcon: Icon(prefixIcon),
              contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              alignLabelWithHint: false,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.blue.withOpacity(0.9))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.black.withOpacity(0.1))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.black.withOpacity(0.4)))),
        ),
      ],
    );
  }
}
