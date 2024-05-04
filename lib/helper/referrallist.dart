// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:final_year/providers/referrprovider.dart';
import 'package:final_year/providers/tokenprovide.dart';
import 'package:final_year/utils/referralhttp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReferralsList extends StatelessWidget {
  final List referrals;

  ReferralsList({required this.referrals});

  @override
  Widget build(BuildContext context) {
    String token = Provider.of<TokenProvider>(context).token;
    print(token);
    final today = DateTime.now();
    return ListView.builder(
      itemCount: referrals.length,
      itemBuilder: (context, index) {
        final referral = referrals[index];
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
                            onPressed: () async {
                              // print(referral['card_number']);
                              final cardnumber = referral['card_number'];
                              final referid = referral['id'].toString();
                              try {
                                final referrdata =
                                    await ReferrState.fetchReferral(
                                        cardnumber, referid, token);
                                Provider.of<ReferrProvider>(context,
                                        listen: false)
                                    .referr = referrdata;

                                print(referrdata);
                                Navigator.pushNamed(
                                  context,
                                  "/referral_detail",
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Error:$e')), // Display error message
                                );
                              }
                            },
                            icon: iconcolor(referral), // Icon
                            label: Text(
                              referral['statustype'],
                              style: TextStyle(
                                  color: referral['statustype'] == 'completed'
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
                          Text(
                            "Referred By: ${referral['referring_hospital']}",
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
                          Text(
                            "Referred To: ${referral['receiving_hospital']}",
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
                                  onPressed: () {
                                    Navigator.pushNamed(context, "/edit");
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
