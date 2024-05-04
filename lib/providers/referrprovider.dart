import 'package:flutter/material.dart';

class ReferrProvider with ChangeNotifier {
Map<String, dynamic> _referr = {};

  // Getter for the patient data
  Map<String, dynamic> get referr => _referr;

  // Setter to update referr data
  set referr(Map<String, dynamic> value) {
    _referr = value;
    notifyListeners(); // Notify listeners about the change
  }
}
