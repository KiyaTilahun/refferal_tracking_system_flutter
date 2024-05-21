import 'package:PRTS/providers/patientprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    var patient = Provider.of<PatientProvider>(context).patient;
    return  Scaffold(
      appBar: AppBar(title: Text("hello"),),
      body: Center(child: Text("$patient")),
    );
  }
}