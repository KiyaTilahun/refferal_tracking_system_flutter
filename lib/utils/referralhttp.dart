import 'dart:js';

import 'package:final_year/providers/tokenprovide.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class ReferrState {
  static Future<Map<String, dynamic>> fetchReferral(
      String referralId, String id, String token) async {
    // print(referralId);
    print(token);
    final url = 'http://127.0.0.1:8000/api/referral/$referralId/referrid/$id';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token', // Using Bearer token
      },
    );

    // return {
    //   "detail": [
    //     {
    //         "Referred By": "Wiegand-Reilly Hospital",
    //         "Referred To": "Dietrich, Altenwerth and Swift Hospital",
    //         "Referral Department": "Urology",
    //         "Appointment Day": "2024-05-21",
    //         "Referral Type": "horizontal",
    //         "Status": "pending",
    //         "Reason": "Quos porro quia et quia nostrud ut incididunt ea"
    //     }
    // ]};

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return parsed JSON data
    } else {
      throw Exception('Failed to load patient data'); // Handle error
    }
  }
}
