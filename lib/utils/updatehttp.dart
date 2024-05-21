// import 'dart:js';

import 'package:PRTS/providers/tokenprovide.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class UpdateAppointment {
  static Future<Map<String, dynamic>> fetchReferral(
      String referralId, String date, String updateddate, String token,String ip) async {
    // print(referralId);
    // print(token);

    final url =
        'http://$ip/api/referral/change/$referralId/date/$date/appointment/update';

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
