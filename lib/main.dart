import 'package:final_year/pages/detailpage.dart';
import 'package:final_year/pages/mainpage.dart';
import 'package:final_year/pages/qrscanner.dart';
import 'package:final_year/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 5));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
     
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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
