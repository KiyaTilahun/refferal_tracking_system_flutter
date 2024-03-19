// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:final_year/main.dart';

import 'package:final_year/theme/appTheme.dart';
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
  final _textController = TextEditingController();
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
     ThemeData theme =Provider.of<ThemeProvider>(context).themedata;

    bool dark = theme==darkTheme?true:false;
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
          actions: [  Language().buildLanguageDropdown(context),],
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, "/welcome_page");
                          }
                        },
                        child: Text(AppLocalizations.of(context)!.submit),
                      ),
                    ]),
              )),
        ));
  }

  // drop down for language
}
