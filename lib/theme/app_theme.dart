import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(useMaterial3: true, colorScheme: const ColorScheme.light());

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.blue,
          onPrimary: Colors.purple,
          secondary: Colors.green,
          onSecondary: Colors.greenAccent,
          error: Colors.red,
          onError: Colors.red,
          background: Colors.black,
          onBackground: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white));
}
