// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final_year/pages/calendarpage.dart';
import 'package:final_year/pages/demo.dart';
import 'package:final_year/pages/detailpage.dart';
import 'package:final_year/pages/mainpage.dart';
import 'package:final_year/pages/qrscanner.dart';
import 'package:final_year/pages/referraldetail.dart';
import 'package:final_year/pages/welcome_page.dart';
import 'package:final_year/providers/appointmentdays.dart';
import 'package:final_year/providers/cardNumberprovider.dart';
import 'package:final_year/providers/ipprovider.dart';
import 'package:final_year/providers/patientprovider.dart';
import 'package:final_year/providers/referrprovider.dart';
import 'package:final_year/providers/tokenprovide.dart';
import 'package:final_year/theme/appTheme.dart';
import 'package:final_year/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';


void main()  {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp( MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),  // Theme management
        ChangeNotifierProvider(create: (_) => TokenProvider()),  // Token management
        ChangeNotifierProvider(create: (_) => PatientProvider()),  // patient management
        ChangeNotifierProvider(create: (_) => CardNumberProvider()),//cardnnumber holder
        ChangeNotifierProvider(create: (_) => ReferrProvider()),  // referr detail management
        ChangeNotifierProvider(create: (_) => AppointmentDaysProvider()),  // Appointment days management
        ChangeNotifierProvider(create: (_) => IpProvider()),  // Appointment days management


         


      ],
      child: MyApp(),
    ),);
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

 @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      
      FlutterNativeSplash.remove();
    });
  }
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
      Locale('am'),Locale('es'),
    ],
      localizationsDelegates: [
        AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    // Add more delegates as needed
  ],
      
theme: Provider.of<ThemeProvider>(context).themedata,
     
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
    '/referral_detail': (context) => const ReferrDetail(),

    '/detail': (context) => const Detail(),
    '/edit': (context) => const Calendar(),
    '/demo': (context) => const Demo(),





  },
      home: const LoginPage(),
    );
  }
}
