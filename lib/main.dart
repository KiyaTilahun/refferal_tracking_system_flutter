// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final_year/pages/detailpage.dart';
import 'package:final_year/pages/mainpage.dart';
import 'package:final_year/pages/qrscanner.dart';
import 'package:final_year/pages/welcome_page.dart';
import 'package:final_year/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
 static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale('en'); // Default locale

  void setLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      supportedLocales: [Locale('en'),
      Locale('am'),
    ],
      localizationsDelegates: [
        AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    // Add more delegates as needed
  ],
      
theme: darkTheme,
     
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      locale: _locale,
      routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    
    // When navigating to the "/second" route, build the SecondScreen widget.
    '/login': (context) => const  LoginPage(),
    '/qrscanner': (context) => const QrPage(),
    '/welcome_page': (context) => const WelcomePage(),
    '/detail': (context) => const Detail(),



  },
      home: const LoginPage(),
    );
  }
}
