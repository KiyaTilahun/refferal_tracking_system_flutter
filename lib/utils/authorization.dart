import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class LoginState {
  static Future<Map<String, dynamic>> fetchPatientData(
      String referralId, String token,String ip) async {
    // print("result");

    final url = 'http://$ip/api/patient/$referralId';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token', // Using Bearer token
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return parsed JSON data
    } else {
      throw Exception('Failed to load patient data'); // Handle error
    }
  }
}
