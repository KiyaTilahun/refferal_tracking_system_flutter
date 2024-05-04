import 'package:final_year/providers/referrprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReferrDetail extends StatefulWidget {
  const ReferrDetail({super.key});

  @override
  State<ReferrDetail> createState() => _ReferrDetailState();
}

class _ReferrDetailState extends State<ReferrDetail> {
  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<ReferrProvider>(context).referr;
    
    List jj = patient['detail'];
    Map patientdata = jj[0];
    List keys = patientdata.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("My Information"),
      ),
      body: Center(
        child: Card(
          clipBehavior: Clip.antiAlias,
          // child: Text('$patientdata'),
          child: ListView.builder(
            itemCount:
                patientdata.length, // Use the length of keys for dynamic rendering
            itemBuilder: (context, index) {
              final key = keys[index];
              return ListTile(
                title: Text('$key : ${patientdata[key]}'),
              );
            },
          ),
        ),
      ),
    );
    ;
  }
}
