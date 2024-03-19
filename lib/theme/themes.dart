// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  
  primaryColor: Colors.black,
  cardTheme: CardTheme(
    color: Colors.white
  ),
  // hintColor: Colors.green, // Accent color, used for buttons, etc.
   // Background color for scaffolds
  appBarTheme: AppBarTheme(
    // color: Colors.blue, // Color for app bar
    // Brightness of the app bar
  
    color: Colors.white
  ),
  // Add more theme properties as needed
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.red,
  backgroundColor: Color(0xFF332940),
  primaryColor: Colors.grey[100],
  indicatorColor: Color(0xffCBDCF8),
  hintColor: Color(0xffEECED3),
  highlightColor: Color(0xffFCE192),
  hoverColor: Color(0xff4285F4),
  focusColor: Color(0xffA8DAB5),
  disabledColor: Colors.grey,
  cardTheme: CardTheme(
    color: Colors.black12
  ),
  
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    // color: Colors.blue, // Color for app bar
    // Brightness of the app bar
  backgroundColor: Colors.black12,
 
  ),
);
