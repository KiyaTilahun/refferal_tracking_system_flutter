// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_interpolation_to_compose_strings, prefer_conditional_assignment

import 'package:final_year/helper/referrallist.dart';
import 'package:final_year/providers/cardNumberprovider.dart';
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
   Map<String, dynamic>? patient;
   bool isRefreshing = true;
    @override
  void initState() {
    super.initState();
    _refreshData(); // Initial data fetch
  }

  Future<void> _refreshData() async {
     setState(() {
      isRefreshing = true; 
    });
    await Provider.of<PatientProvider>(context, listen: false).fetchPatientData(); 
    setState(() {
      patient = Provider.of<PatientProvider>(context, listen: false).patient; 
      isRefreshing = false; 

    });
  }


  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).themedata;

    bool dark = theme == darkTheme ? true : false;

   
      patient = Provider.of<PatientProvider>(context).patient;
    

    Provider.of<CardNumberProvider>(context, listen: false).cardnumber =
        patient?['patient']['Referral Id'];
    List referrals = patient?['referrals'];
    if (patient != null) {
      // Map<String, dynamic> patientdetail = patient['patient'];
    }
    return Scaffold(
        appBar: AppBar(
          actions: [
             if (isRefreshing)
            Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white), 
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/detail");
                },
                icon: Icon(Icons.person), // This uses the "person" icon
                tooltip: 'Edit Profile'),
            IconButton(
                onPressed: () {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();

                  setState(() {
                    dark = !dark;
                  });
                },
                icon: dark ? icons[0] : icons[1]),
                 IconButton(
            icon: Icon(Icons.refresh), 
            onPressed: _refreshData, 
          ),
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
            
            child: RefreshIndicator(onRefresh:_refreshData,child: ReferralsList(referrals: referrals))));
  }
}

List<Icon> icons = [
  Icon(Icons.sunny, color: Colors.white), // For name
  Icon(
    Icons.nights_stay,
  ),
];
