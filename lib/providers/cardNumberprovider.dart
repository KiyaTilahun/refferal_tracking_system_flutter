import 'package:flutter/material.dart';

class CardNumberProvider with ChangeNotifier {
String _cardnumber = '';

  // Getter for the cardnumber data
  String get cardnumber => _cardnumber;

  // Setter to update cardnumber data
  set cardnumber(String value) {
    _cardnumber = value;
    notifyListeners(); // Notify listeners about the change
  }
}
