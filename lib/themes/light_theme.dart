import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(  
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  cardColor: Colors.white,
  fontFamily: 'Lato',
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF35959e),
    outline: Colors.grey.shade300,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      minimumSize: Size(double.infinity, 45),
    ),
  ),
);
