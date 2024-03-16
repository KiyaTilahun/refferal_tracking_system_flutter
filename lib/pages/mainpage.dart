// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
          padding: EdgeInsets.all(20.0), // Adjust padding as needed
          child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                           Navigator.pushNamed(context, '/qrscanner');
                        },
                        child: Row(
                          children: [
                            Text("Using QR Code"),
                            Icon(Icons.qr_code_scanner)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 30),
                  ),
                  TextFormField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: 'Enter Referral Number Here',
                      border: OutlineInputBorder(),
                      hintText: 'Type here...',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _textController.clear();
                        },
                        icon: Icon(Icons.clear),
                      ),
                    ),
                    validator: (reference) {
                      if (reference!.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (reference.length < 5) {
                        return 'Text must be at least 5 characters long';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _text = newValue!;
                    },
                  ),
                  SizedBox(
                      height: 20.0), // Add space between TextField and button
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue), // Change background color
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white), // Change text color
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Text submitted: $_text'),
                          ),
                        );
                      }
                    },
                    child: Text('Submit'),
                  ),
                ]),
          )),
    ));
  }
}
