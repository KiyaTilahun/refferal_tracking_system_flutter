// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  String getResult = "Scan";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Code"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getResult),
            ElevatedButton(
              child: Text("click me"),
              onPressed: () {
                qrCode();
              },
            ),
          ],
        ),
      ),
    );
  }

  void qrCode() async {
    try {
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", false, ScanMode.QR);
      if (mounted) {
        print("mounted");
      }
      
      setState(() {
        getResult = barcodeScanRes;
      });
    } on PlatformException {
      getResult = "Failed to Retreive Data";
    }
  }
}
