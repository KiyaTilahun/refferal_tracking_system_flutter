// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:final_year/providers/appointmentdays.dart';
import 'package:final_year/providers/cardNumberprovider.dart';
import 'package:final_year/providers/ipprovider.dart';
import 'package:final_year/providers/referrprovider.dart';
import 'package:final_year/providers/tokenprovide.dart';
import 'package:final_year/utils/appointmenthttp.dart';
import 'package:final_year/utils/referralhttp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReferralsList extends StatefulWidget {
  final List referrals;

  ReferralsList({required this.referrals});

  @override
  State<ReferralsList> createState() => _ReferralsListState();
}

class _ReferralsListState extends State<ReferralsList> {
  int? _loadingIndex;

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<TokenProvider>(context).token;
    String referralcard=Provider.of<CardNumberProvider>(context).cardnumber;
    String ip = Provider.of<IpProvider>(context,listen: false).ipnumber;
    print(token);
    final today = DateTime.now();
    return ListView.builder(
      itemCount: widget.referrals.length,
      itemBuilder: (context, index) {
        final referral = widget.referrals[index];
        final referralDate = DateTime.parse(referral['referral_date']);
        final datename = DateFormat.yMMMMd()
            .format(DateTime.parse(referral['referral_date']));
        final Color containerColor = referral['statustype'] == 'completed'
            ? Colors.green
            : Colors.orange;
        final referralicon = Icon(
          referral['statustype'] == 'completed'
              ? Icons.check_circle
              : Icons.hourglass_empty,
        );
        // return Text("Referral ID: ${referral['id']}");
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 150,
                width: 10,
                color: containerColor,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Referral ID: ${referral['id']}",
                          ),
                          ElevatedButton.icon(
                            onPressed: _loadingIndex == index
                                ? null // Disable if loading
                                : () async {
                                    setState(() {
                                      _loadingIndex = index; // Start loading
                                    });
                                    final cardnumber = referral['card_number'];
                                    final referid = referral['id'].toString();
                                    try {
                                      final referrdata =
                                          await ReferrState.fetchReferral(
                                              cardnumber, referid, token,ip);
                                      Provider.of<ReferrProvider>(context,
                                              listen: false)
                                          .referr = referrdata;

                                      print(referrdata);
                                      Navigator.pushNamed(
                                        context,
                                        "/referral_detail",
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Error:$e')), // Display error message
                                      );
                                    } finally {
                                      setState(() {
                                        _loadingIndex = null; // Start loading
                                      });
                                    }
                                  },
                            icon: _loadingIndex == index
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      referral['statustype'] == 'completed'
                                          ? Colors.green
                                          : Colors.orange,
                                    ),
                                  ) // Show spinner when loading
                                : iconcolor(referral),
                            label: _loadingIndex == index
                                ? Text("") // Empty text during loading
                                : Text(
                                    referral['statustype'],
                                    style: TextStyle(
                                        color: referral['statustype'] ==
                                                'completed'
                                            ? Colors.green
                                            : Colors.orange),
                                  ), // Text
                          ),
                        ],
                      ),
                      Container(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons
                                .local_hospital_rounded, // Choose the icon you want
                            color: Colors
                                .green, // Customize the icon color if needed
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Referred By: ${referral['referring_hospital']}",
                             softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.local_hospital, // Choose the icon you want
                            color: Colors
                                .blue, // Customize the icon color if needed
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Referred To: ${referral['receiving_hospital']}",
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.calendar_month, // Choose the icon you want
                            color: Colors
                                .blue, // Customize the icon color if needed
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                // "Referral Date: ${referral['referral_date']}",
                                "Referral Date: $datename",
                              ),
                              if (referralDate.isAfter(today) &&
                                  referral['statustype'] == "pending")
                                IconButton(
                                  onPressed: () async {
                                    final referrdate = referral['referral_date'];
                                  
                                    try {
                                      final appointmentdata =
                                          await AppointmentState.fetchReferral(
                                              referralcard, referrdate, token,ip);
                                      Provider.of<AppointmentDaysProvider>(context,
                                              listen: false)
                                          .days = appointmentdata;

                                      // print(referrdata);
                                      Navigator.pushNamed(
                                        context,
                                        "/edit",arguments: referrdate
                                      );
                                    } catch (e) {
                                       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: Try Again Later')),
      );
                                    }
                                    // Navigator.pushNamed(context, "/edit");
                                  },
                                  icon: const Icon(Icons.edit),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Icon iconcolor(referral) {
    final IconData iconData = referral['statustype'] == 'completed'
        ? Icons.check_circle
        : Icons.hourglass_empty;

    final Color iconColor =
        referral['statustype'] == 'completed' ? Colors.green : Colors.orange;

    final Icon referralIcon = Icon(
      iconData,
      color: iconColor, // Set the color based on the status type
    );

    return referralIcon;
  }
}
