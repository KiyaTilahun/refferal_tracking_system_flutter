// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_interpolation_to_compose_strings, prefer_conditional_assignment

import 'package:PRTS/helper/referrallist.dart';
import 'package:PRTS/pages/mainpage.dart';
import 'package:getwidget/getwidget.dart';

// import 'package:PRTS/providers/appointmentdays.dart';
import 'package:PRTS/providers/cardNumberprovider.dart';
import 'package:PRTS/providers/ipprovider.dart';
import 'package:PRTS/providers/patientprovider.dart';
import 'package:PRTS/providers/tokenprovide.dart';
import 'package:PRTS/theme/appTheme.dart';
import 'package:PRTS/theme/themes.dart';
import 'package:PRTS/utils/authorization.dart';
import 'package:PRTS/utils/language.dart';
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
  bool isRefreshing = false;
  Map<String, dynamic>? patient;

  @override
  void initState() {
    super.initState();
// WidgetsBinding.instance.addPostFrameCallback((_) {
//       _refreshData();
//     });
    // _refreshData();
    isRefreshing = false; // Initial data fetch
  }

  Future<void> _refreshData() async {
    setState(() {
      isRefreshing = true;
    });
    String token = Provider.of<TokenProvider>(context,listen: false).token;
    String card = Provider.of<CardNumberProvider>(context,listen: false).cardnumber;
    String ip = Provider.of<IpProvider>(context,listen: false).ipnumber;
    
    print(card + token);
    try {
      var patientdata = await LoginState.fetchPatientData(card, token,ip);
      print(patientdata);
      setState(() {
        patient = patientdata;
        print(patient);
        isRefreshing = false;
        Provider.of<PatientProvider>(context, listen: false).patient =
            patientdata;
      });
    } catch (e) {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    //  Provider.of<AppointmentDaysProvider>(context).days = {};
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
       backgroundColor: Colors.black,
       foregroundColor: Colors.white,
          actions: [
            if (isRefreshing)
              Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: theme == darkTheme ? Colors.white : Colors.green,
                  ),
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
        drawer: GFDrawer(
           
            child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // DrawerHeader(
            //   // decoration: BoxDecoration(
            //   //   color: Colors.blue,
            //   // ),
             
            // ),

            Padding(
              padding: const EdgeInsets.all(16.0),
             child: Image.asset(
                'assets/images/mylogo.png',
                fit: BoxFit.cover,
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
             ListTile(
                // leading: Icon(Icons.language_rounded),

                leading: Language().buildLanguageDropdown(context)),
                 Divider(
              height: 1,
              thickness: 1,
            ),
             Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text(AppLocalizations.of(context)!.logout),
              onTap: () {
                // Implement your logout logic here
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
            ),
            
           
          ],
        ) // Populate the Drawer in the next step.
            ),
        body: Column(
            children: [Expanded(
                
                child: ReferralsList(referrals: referrals))]));
  }
}

List<Icon> icons = [
  Icon(Icons.sunny, color: Colors.white), // For name
  Icon(
    Icons.nights_stay,
  ),
];
