// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          title: Text("Welcome"),
        ),
         drawer: Drawer(
    child: ListView(padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              // Implement your logout logic here
            },
          ),
          ListTile(
            title: Text('Change Language'),
            trailing: DropdownButton<String>(
              value: 'English', // Default language value
              onChanged: (String? newValue) {
                // Implement language change logic here
              },
              items: <String>['English', 'Spanish', 'French']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],)// Populate the Drawer in the next step.
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
                                  label: Text('See More'), // Text
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
                                  "Reffered by:Jimma Health Center",
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
                                  "Reffered by:Jimma Health Center",
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    
                                    Text("Appointement Day:22/12/2024"),
                                    
                                    IconButton(style: ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(Colors.red),foregroundColor:  MaterialStateProperty.all<Color>(Colors.white),),onPressed: (){}, icon: Icon(Icons.edit))
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
