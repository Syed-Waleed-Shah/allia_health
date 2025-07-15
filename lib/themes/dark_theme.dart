import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.deepPurple,
    outline: Colors.grey.shade300,
  ),
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.black,
  cardColor: Colors.black,
);
