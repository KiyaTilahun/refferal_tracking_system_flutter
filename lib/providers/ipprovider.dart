import 'package:flutter/material.dart';

class IpProvider with ChangeNotifier {
String _ipnumber = '';

  // Getter for the ipnumber data
  String get ipnumber => _ipnumber;

  // Setter to update ipnumber data
  set ipnumber(String value) {
    _ipnumber = value;
    notifyListeners(); // Notify listeners about the change
  }
}
