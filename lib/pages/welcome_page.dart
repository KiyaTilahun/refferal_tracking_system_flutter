// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, unnecessary_import, prefer_interpolation_to_compose_strings

import 'package:final_year/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
              },
            ),
            ListTile(
              // leading: Icon(Icons.language_rounded),
              
              leading: Language().buildLanguageDropdown(context)
            ),
          ],
        ) // Populate the Drawer in the next step.
            ),
        body: Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 150,
                      width: 10,
                      color: Colors.red,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mr.Kiya Tilahun",
                                  style: TextStyle(
                                    color: Colors.blue[800],
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/detail");
                                  },
                                  icon: Icon(Icons.remove_red_eye), // Icon
                                  label: Text(AppLocalizations.of(context)!.seeMore), // Text
                                ),
                              ],
                            ),
                            // Add some spacing between the title and the subtitle
                            Container(height: 5),
                            // Add a subtitle widget
                            Row(
                              children: [
                                Icon(
                                  Icons
                                      .local_hospital_rounded, // Choose the icon you want
                                  color: Colors
                                      .green, // Customize the icon color if needed
                                ),
                                SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)!.referredBy +"Jimma Health Center",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                            Container(height: 5),
                            Row(
                              children: [
                                Icon(
                                  Icons
                                      .local_hospital, // Choose the icon you want
                                  color: Colors
                                      .blue, // Customize the icon color if needed
                                ),
                                SizedBox(width: 8),
                                Text(
                                  AppLocalizations.of(context)!.referredTo +"Mizan Health Center",
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons
                                      .calendar_month, // Choose the icon you want
                                  color: Colors
                                      .blue, // Customize the icon color if needed
                                ),
                                SizedBox(width: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text( AppLocalizations.of(context)!.appointementDate+":22/12/2024"),
                                    IconButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.red),
                                          foregroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.white),
                                        ),
                                        onPressed: () {},
                                        icon: Icon(Icons.edit))
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
