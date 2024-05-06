import 'package:flutter/material.dart';

class PatientProvider with ChangeNotifier {
  Map<String, dynamic> _patient = {};

  // Getter for the patient data
  Map<String, dynamic> get patient => _patient;

  // Setter to update patient data
  set patient(Map<String, dynamic> value) {
    _patient = value;
    notifyListeners(); // Notify listeners about the change
  }

  Future<void> fetchPatientData() async {
    await Future.delayed(Duration(seconds: 2));
    notifyListeners();
    
  }
}
