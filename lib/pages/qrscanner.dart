// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:convert';

import 'package:PRTS/providers/cardNumberprovider.dart';
import 'package:PRTS/providers/ipprovider.dart';
import 'package:PRTS/providers/patientprovider.dart';
import 'package:PRTS/providers/tokenprovide.dart';
import 'package:PRTS/utils/authorization.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  String token = '';
  String referralId = '';
  String getResult = "Scan the QR code on your Referral paper";
  final _networkContoller = TextEditingController();
  bool isLoader = false;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(AppLocalizations.of(context)!.loginPageTitle),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Qr_scanner.png',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 16,
                ),

                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.blue), // Change background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white), // Change text color
                  ),
                  child: Text(AppLocalizations.of(context)!.scan),
                  onPressed: () {
                    qrCode();
                  },
                ),
                SizedBox(
                  height: 24,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Background color
                    foregroundColor:
                        Colors.white, // Text Color (Foreground color)
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.date_range), // Icon for the "to" button
                      SizedBox(width: 5), // Spacing between icon and text
                      Text(
                        AppLocalizations.of(context)!.qrid + referralId,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // Background color
                    foregroundColor:
                        Colors.white, // Text Color (Foreground color)
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.date_range), // Icon for the "to" button
                      SizedBox(width: 5), // Spacing between icon and text
                      Text(
                        AppLocalizations.of(context)!.qrtoken + token,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),

                TextFormField(
                  controller: _networkContoller,
                  decoration: InputDecoration(
                    hintText: "Ip",
                    hintStyle: TextStyle(
                      fontSize: 14.0,
                      color: Color.fromRGBO(124, 124, 124, 1),
                      fontWeight: FontWeight.w600,
                    ),
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
                    height: 20.0), // Add space between TextField and button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Change background color
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Change text color
                      ),
                      onPressed: (!isLoader)
                          ? () async {
                              if (_formKey.currentState!.validate()) {
                                final ipadress = _networkContoller.text;
                                try {
                                  setState(() {
                                    isLoader = true;
                                  });

                                  final patientData =
                                      await LoginState.fetchPatientData(
                                          referralId, token, ipadress);
                                  if (patientData != null) {
                                    Provider.of<TokenProvider>(context,
                                            listen: false)
                                        .token = token;
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
                                      // ignore: use_build_context_synchronously
                                      context,
                                      "/welcome_page",
                                    );
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        showCloseIcon: true,
                                        backgroundColor: Colors.red.shade400,
                                        action: SnackBarAction(
                                          label: 'Ok',
                                          onPressed: () {},
                                        ),
                                        content: Text(AppLocalizations.of(
                                                context)!
                                            .loginerror)), // Display error message
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
                          : Text(AppLocalizations.of(context)!.submit),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void qrCode() async {
    try {
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.QR);
      if (mounted) {
        print("mounted");
      }
      if (barcodeScanRes == "-1") {
        // User canceled the scan
        print("Scan canceled");
      } else {
        Map<String, dynamic> jsonResult;

        try {
          jsonResult = jsonDecode(barcodeScanRes)
              as Map<String, dynamic>; // Parse the string as JSON

          setState(() {
            referralId = jsonResult['referral_id'];
            token = jsonResult['token']; // Store the JSON result
          });
        } catch (e) {
          // Handle invalid JSON data
          setState(() {
            getResult = "Invalid JSON format";
          });
        }
      }

      setState(() {
        getResult = barcodeScanRes;
      });
    } on PlatformException {
      getResult = "Failed to Retreive Data";
    }
  }
}
