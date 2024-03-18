// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';

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
     final parsedData = json.decode(jsonData)['data'][0];
     final List<Icon> icons = [
  Icon(Icons.person), // For name
  Icon(Icons.cake), // For age
  Icon(Icons.person_2_rounded), // For gender
  Icon(Icons.check_circle), // For status
];

    return  Scaffold(
       appBar: AppBar(
          title: Text("My Information"),
        ),
        body: Center(child:   Card(
              clipBehavior: Clip.antiAlias,child:  ListView.builder(
          itemCount: parsedData.keys.length, // Use the length of keys for dynamic rendering
          itemBuilder: (context, index) {
            final label = parsedData.keys.toList()[index];
            final value = parsedData[label];
            return ListTile(
           leading: icons[index],
          title: Text(value),
          subtitle: Text(label),
             
            );
          },
        ),),),
    );
  }
}