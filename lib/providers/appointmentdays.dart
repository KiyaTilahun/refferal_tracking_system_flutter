import 'package:flutter/material.dart';

class AppointmentDaysProvider with ChangeNotifier {
Map<String, dynamic> _days = {};

  // Getter for the patient data
  Map<String, dynamic> get days => _days;

  // Setter to update days data
  set days(Map<String, dynamic> value) {
    _days = value;
    notifyListeners(); // Notify listeners about the change
  }
}
