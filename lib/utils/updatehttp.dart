import 'dart:js';

import 'package:final_year/providers/tokenprovide.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class UpdateAppointment {
  static Future<Map<String, dynamic>> fetchReferral(
      String referralId, String date, String updateddate, String token) async {
    // print(referralId);
    // print(token);

    final url =
        'http://127.0.0.1:8000/api/referral/change/$referralId/date/$date/appointment/update';

    final response = await http.patch(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token', // Using Bearer token
    }, body: {
      "changedate": updateddate
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Return parsed JSON data
    } else {
      throw Exception(response.body); // Handle error
    }
  }
}
