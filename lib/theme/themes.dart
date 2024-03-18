// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue, // Primary color for your app
  hintColor: Colors.green, // Accent color, used for buttons, etc.
  backgroundColor: Colors.white, // Background color for the app
  scaffoldBackgroundColor: Colors.white, // Background color for scaffolds
  appBarTheme: AppBarTheme(
    // color: Colors.blue, // Color for app bar
    // Brightness of the app bar
    iconTheme: IconThemeData(color: Colors.white),
    toolbarTextStyle: TextTheme(
      headline6: TextStyle(color: Colors.white), // Text color for app bar title
    ).bodyText2,
    titleTextStyle: TextTheme(
      headline6: TextStyle(color: Colors.white), // Text color for app bar title
    ).headline6,
  ),
  // Add more theme properties as needed
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  backgroundColor: Color(0xFF332940),
  
  primaryColor: Colors.grey,

  indicatorColor: Color(0xffCBDCF8),
  
  hintColor: Color(0xffEECED3),
  highlightColor: Color(0xffFCE192),
  hoverColor: Color(0xff4285F4),
  focusColor: Color(0xffA8DAB5),
  disabledColor: Colors.grey,
  
  cardColor: Colors.white,
  canvasColor: Colors.grey[50],
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    elevation: 0.0,
  ),
);
