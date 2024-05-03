import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginState {
  static Future<Map<String, dynamic>> fetchPatientData(
      String referralId, String token) async {
    print(referralId);

    final url = 'http://127.0.0.1:8000/api/patient/$referralId';

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
