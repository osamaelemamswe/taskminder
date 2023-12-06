import 'package:flutter/material.dart';
import 'package:taskminder/styles/colors.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  primarySwatch: primaryMaterialColor,
  scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF5F5F5),
    elevation: 0.0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    elevation: 0.0,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: primaryColor,
    secondary: primaryColor,
  ),
  fontFamily: 'Montserrat',
  primarySwatch: primaryMaterialColor,
  scaffoldBackgroundColor: const Color(0xFF121920),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF121920),
    elevation: 0.0,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xFF0F141A),
  ),
);