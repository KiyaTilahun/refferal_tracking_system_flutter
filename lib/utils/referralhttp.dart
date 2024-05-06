// import 'dart:js';

import 'package:final_year/providers/tokenprovide.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class ReferrState {
  static Future<Map<String, dynamic>> fetchReferral(
      String referralId, String id, String token,String ip) async {
    // print(referralId);
    print(token);
    final url = 'http://$ip/api/referral/$referralId/referrid/$id';

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
