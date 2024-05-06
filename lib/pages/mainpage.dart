// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'package:final_year/main.dart';
import 'package:final_year/providers/cardNumberprovider.dart';
import 'package:final_year/providers/ipprovider.dart';
import 'package:final_year/providers/patientprovider.dart';
import 'package:final_year/providers/referrprovider.dart';
import 'package:final_year/providers/tokenprovide.dart';

import 'package:final_year/theme/appTheme.dart';
import 'package:final_year/utils/authorization.dart';
import 'package:final_year/utils/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:final_year/theme/themes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  bool isLoader = false;
  final _textController = TextEditingController();
  final _tokenController = TextEditingController();
  final _networkContoller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  late AnimationController _controller;
  late Animation<double> _animation;
  String _text = '';

  List<Icon> icons = [
    Icon(Icons.sunny, color: Colors.white), // For name
    Icon(
      Icons.nights_stay,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _animation = Tween<double>(begin: 1, end: 1.1).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Provider.of<ThemeProvider>(context).themedata;

    bool dark = theme == darkTheme ? true : false;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();

                setState(() {
                  dark = !dark;
                });
              },
              icon: dark ? icons[0] : icons[1]),
          actions: [
            Language().buildLanguageDropdown(context),
          ],
        ),
        body: Center(
          child: Padding(
              padding: EdgeInsets.all(20.0), // Adjust padding as needed
              child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/qrscanner');
                            },
                            child: ScaleTransition(
                              scale: _animation,
                              child: Row(
                                children: [
                                  Text(AppLocalizations.of(context)!.qrcode),
                                  Icon(Icons.qr_code_scanner)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        AppLocalizations.of(context)!.loginPageTitle,
                        style: TextStyle(fontSize: 30),
                      ),
                      TextFormField(
                        controller: _textController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.refferalid,
                          border: OutlineInputBorder(),
                          hintText: 'Type here...',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _textController.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        validator: (reference) {
                          if (reference!.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (reference.length < 5) {
                            return 'Text must be at least 5 characters long';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _text = newValue!;
                        },
                      ),
                      SizedBox(height: 20.0),

                      TextFormField(
                        controller: _tokenController,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.token,
                          border: OutlineInputBorder(),
                          hintText: 'Type here...',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _tokenController.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        validator: (reference) {
                          if (reference!.isEmpty) {
                            return 'Please enter some text';
                          }
                          if (reference.length < 5) {
                            return 'Text must be at least 5 characters long';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _text = newValue!;
                        },
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        controller: _networkContoller,
                        decoration: InputDecoration(
                          labelText: "Ip Address",
                          border: OutlineInputBorder(),
                          hintText: 'Type here...',
                          suffixIcon: IconButton(
                            onPressed: () {
                              _networkContoller.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        validator: (reference) {
                          if (reference!.isEmpty) {
                            return 'Please enter valid Ip';
                          }

                          return null;
                        },
                      ),
                      SizedBox(
                          height:
                              20.0), // Add space between TextField and button
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blue), // Change background color
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Change text color
                        ),
                        onPressed: (!isLoader)
                            ? () async {
                                //     if (_formKey.currentState!.validate()) {
                                //       final referralId = _textController.text;
                                //       final token = _tokenController.text;
                                //       try {
                                //         // print(token);
                                //         final patientData =
                                //             await LoginState.fetchPatientData(
                                //                 referralId, token);
                                //         // ignore: use_build_context_synchronously
                                //         Provider.of<TokenProvider>(context, listen: false)
                                //             .token = token;
                                //              Provider.of<PatientProvider>(context, listen: false)
                                //             .patient = patientData;
                                //         // print('Patient Data: $patientData');
                                //         // Log the result or process further
                                //         Navigator.pushNamed(context, "/welcome_page",arguments: patientData,
                                // );
                                //       } catch (e) {
                                //         ScaffoldMessenger.of(context).showSnackBar(
                                //           SnackBar(
                                //               content: Text(
                                //                   'Error: Check Your Card or Token')), // Display error message
                                //         );
                                //       }
                                //     }

                                if (_formKey.currentState!.validate()) {
                                  final referralId = _textController.text;
                                  final token = _tokenController.text;
                                  final ipadress = _networkContoller.text;
                                  try {
                                    setState(() {
                                      isLoader = true;
                                    });
                                    // final patientData =
                                    //     await LoginState.fetchPatientData(
                                    //         "REF8700H1Dkiya052024",
                                    //         "1|hWEn5BUnMoWy5SMkoX6jMhhr9AwRlpKT6L0VkOzM239415f4",
                                    //         "192.168.1.12:8000");

                                              final patientData =
                                             await LoginState.fetchPatientData(
                                                 referralId, token,ipadress);
                                    if (patientData != null) {
                                      Provider.of<TokenProvider>(context,
                                                  listen: false)
                                              .token =
                                          token;
                                      Provider.of<IpProvider>(context,
                                              listen: false)
                                          .ipnumber = ipadress;

                                      Provider.of<CardNumberProvider>(context,
                                              listen: false)
                                          .cardnumber = referralId;

                                      Provider.of<PatientProvider>(context,
                                              listen: false)
                                          .patient = patientData;
                                      // print('Patient Data: $patientData');
                                      // Log the result or process further
                                      Navigator.pushNamed(
                                        context,
                                        "/welcome_page",
                                      );
                                      // Navigator.pushNamed(
                                      //   context,
                                      //   "/demo",
                                        
                                      // );
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Error: Check Your Card or Token')), // Display error message
                                    );
                                  } finally {
                                    setState(() {
                                      isLoader = false;
                                    });
                                  }
                                }
                              }
                            : null,
                        child: isLoader
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text("Submit"),
                      ),
                    ]),
              )),
        ));
  }

  // drop down for language
}
