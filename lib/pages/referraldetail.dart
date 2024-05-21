// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:PRTS/providers/referrprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


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
    final List<Icon> icons = [
      Icon(Icons.local_hospital), // Referred By
      Icon(Icons.business_center), // Referred To
      Icon(Icons.apartment), // Referral Department
      Icon(Icons.calendar_today), // Appointment Day
      Icon(Icons.note), // Referral Type
      Icon(Icons.check_circle), // Status
      Icon(Icons.help_outline), // Reason
      Icon(Icons.search), // Findings
    ];
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        actions: [
          Container(
            decoration: BoxDecoration(
              color: patientdata['Status'] == "completed"
                  ? Colors.green
                  : Colors.orange, // Background color based on status
              borderRadius: BorderRadius.circular(5), // Slight border radius
            ),
            child: ElevatedButton(
          onPressed: () {
  
          },
  style: ElevatedButton.styleFrom(
            backgroundColor: patientdata['Status'] == 'completed'
                ? Colors.green // Use green if "completed"
                : Colors.orange, // Use orange if not
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center align
            children: [
              Icon(Icons.calendar_month,color: Colors.white,), // Leading icon
              SizedBox(width: 8), // Space between icon and text
              Text(patientdata['Status']=='completed'?AppLocalizations.of(
                                                context)!
                                            .completed:AppLocalizations.of(
                                                context)!
                                            .pending,style: TextStyle(color: Colors.white),), // Button text
            ],
          ),
        ),
          ),
          if (patientdata['Status'] ==
              "pending") // Conditionally add the edit icon
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Action for edit icon when status is pending
                print("Edit icon pressed");
              },
            ),
        ],
        title: Text(AppLocalizations.of(context)!.detailtitle),
      ),
      body: Center(
        child: Card(
          clipBehavior: Clip.antiAlias,
          // child: Text('$patientdata'),
          child: ListView.builder(
            itemCount: patientdata
                .length, // Use the length of keys for dynamic rendering
            itemBuilder: (context, index) {
              final key = keys[index];
              // return ListTile(
              //   title: Text('$key : ${patientdata[key]}'),
              // );
              return ExpansionTile(
                title: Text(
                  key,
                  style: TextStyle(fontFamily: 'Roboto', fontSize: 16),
                ),
                leading: icons[index],
                children: [
                  ListTile(
                    title: Text(
                      '$key : ${patientdata[key]}',
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
    ;
  }
}
