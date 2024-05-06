// ignore_for_file: prefer_const_constructors

// import 'dart:convert';
// import 'dart:js';

import 'package:final_year/providers/patientprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});
  final String jsonData = '''
    {
      "data": [
        {"name": "John", "age": "30", "gender": "Male", "status": "Active"},
        {"name": "Alice", "age": "25", "gender": "Female", "status": "Inactive"}
      ]
    }
  ''';

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<PatientProvider>(context).patient;
    Map referrals = patient['patient'];
    //  final parsedData = json.decode(jsonData)['data'][0];
    final List parsedData = referrals.keys.toList();
    final List parsedValue = referrals.values.toList();

    final List<Icon> icons = [
      Icon(Icons.person),
      Icon(Icons.confirmation_number),
      Icon(Icons.phone),
      Icon(Icons.transgender),
      Icon(Icons.email),
      Icon(Icons.local_hospital),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("My Information"),
      ),
      body: Center(
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: ListView.builder(
            itemCount: parsedData
                .length, // Use the length of keys for dynamic rendering
            itemBuilder: (context, index) {
              final key = parsedData[index];
              return ListTile(
                leading: icons[index],
                title: Text('$key : ${referrals[key]}'),
              );
            },
          ),
        ),
      ),
    );
  }
}
