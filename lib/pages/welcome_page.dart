// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_interpolation_to_compose_strings

import 'package:final_year/helper/referrallist.dart';
import 'package:final_year/providers/patientprovider.dart';
import 'package:final_year/theme/appTheme.dart';
import 'package:final_year/theme/themes.dart';
import 'package:final_year/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).themedata;

    bool dark = theme == darkTheme ? true : false;
    // final args =ModalRoute.of(context)?.settings.arguments as Map<String,dynamic>;
    // print(args);

    final patient = Provider.of<PatientProvider>(context).patient;
    List referrals = patient['referrals'];
    if (patient != null) {
      // Map<String, dynamic> patientdetail = patient['patient'];
    }
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){ Navigator.pushNamed(context, "/detail");}, icon: Icon(Icons.person), // This uses the "person" icon
            tooltip: 'Edit Profile' ),
            IconButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();

                  setState(() {
                    dark = !dark;
                  });
                },
                icon: dark ? icons[0] : icons[1]),
          ],
          title: Text(AppLocalizations.of(context)!.welcome),
        ),
        drawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              // decoration: BoxDecoration(
              //   color: Colors.blue,
              // ),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text(AppLocalizations.of(context)!.logout),
              onTap: () {
                // Implement your logout logic here
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
            ),
            ListTile(
                // leading: Icon(Icons.language_rounded),

                leading: Language().buildLanguageDropdown(context)),
          ],
        ) // Populate the Drawer in the next step.
            ),
        body: Expanded(
      //     child:ListView.builder(
      // itemCount: referrals.length,
      // itemBuilder: (context, index) {
      //   final referral = referrals[index];

      //   return Text("Referral ID:");})
             child:ReferralsList(referrals: referrals)

        ));
  }
}

List<Icon> icons = [
  Icon(Icons.sunny, color: Colors.white), // For name
  Icon(
    Icons.nights_stay,
  ),
];
