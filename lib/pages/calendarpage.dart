// ignore_for_file: prefer_const_constructors, unused_element, deprecated_member_use, avoid_print, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:final_year/providers/appointmentdays.dart';
import 'package:final_year/providers/cardNumberprovider.dart';
import 'package:final_year/providers/ipprovider.dart';
import 'package:final_year/providers/patientprovider.dart';
import 'package:final_year/providers/tokenprovide.dart';
import 'package:final_year/utils/authorization.dart';
import 'package:final_year/utils/updatehttp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

CalendarFormat _calendarFormat = CalendarFormat.month;

DateTime _focusedDay = DateTime.now();
DateTime? _selectedDay;
DateTime? _appointmentDate = DateTime.now();

class _CalendarState extends State<Calendar> {
  final _textController = TextEditingController();
  bool isLoading = false;
  DateTime? selected;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as String?;

    if (arguments != null) {
      // Parse the string to DateTime
      _focusedDay = DateTime.parse(arguments);
    } else {
      _focusedDay = DateTime.now(); // Default focus if no argument is provided
    }
    final initalapp = DateFormat('yyyy-MM-dd').format(_focusedDay);
    @override
    void initState() {
      super.initState();

      _focusedDay = DateTime(
        _focusedDay.year,
        _focusedDay.month,
        _focusedDay.day,
      ); // Resetting hour, minute, second to 0
    }

    final patient = Provider.of<AppointmentDaysProvider>(context).days;
    String token = Provider.of<TokenProvider>(context).token;
    String cardnumber = Provider.of<CardNumberProvider>(context).cardnumber;
    String ip = Provider.of<IpProvider>(context, listen: false).ipnumber;
    String referralcard = Provider.of<CardNumberProvider>(context).cardnumber;

    List<String> enabledDates = List<String>.from(patient["days"]);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Appointment"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime(2024, 1, 1),
                lastDay: DateTime(2025, 12, 31),
                focusedDay: _focusedDay,
                headerStyle: HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                enabledDayPredicate: (date) {
                  String formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  return enabledDates.contains(formattedDate);
                },
                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(
                    color: Colors.green,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.red, // Change this for selected dates
                    shape: BoxShape.circle,
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    selected = selectedDay;
                  });
                  _focusedDay = focusedDay;
                },
              ),
              SizedBox(
                height: 10,
              ),
              const Divider(
                height: 20,
                thickness: 1,
                indent: 20,
                color: Colors.green,
              ),
              // The correct use of Expanded to avoid "Incorrect use of ParentDataWidget"
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Change Appointment"),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green, // Background color
                              foregroundColor:
                                  Colors.white, // Text Color (Foreground color)
                            ),
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(Icons
                                    .date_range), // Icon for the "to" button
                                SizedBox(
                                    width: 5), // Spacing between icon and text
                                Text(
                                  "Initial Appointment : ${DateFormat('MM/dd/yyyy').format(_focusedDay)}",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          if (selected == null)
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orange, // Background color
                                foregroundColor: Colors
                                    .white, // Text Color (Foreground color)
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons
                                      .date_range), // Icon for the "to" button
                                  SizedBox(
                                      width:
                                          5), // Spacing between icon and text
                                  Text(
                                    "To: YYYY/MM/DD",
                                  ),
                                ],
                              ),
                            ),
                          if (selected != null) // Avoiding null in the display
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.orange, // Background color
                                foregroundColor: Colors
                                    .white, // Text Color (Foreground color)
                              ),
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Icon(Icons
                                      .date_range), // Icon for the "to" button
                                  SizedBox(
                                      width:
                                          5), // Spacing between icon and text
                                  Text(
                                    "To: ${DateFormat('MM/dd/yyyy').format(selected!)}",
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selected != null ? Colors.blue : Colors.grey,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: (selected != null && !isLoading)
                          ? () async {
                              setState(() {
                                isLoading = true;
                              });

                              try {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(selected!);

                                await Future.delayed(Duration(seconds: 2));
                                final appointmentdata =
                                    await UpdateAppointment.fetchReferral(
                                        referralcard,
                                        initalapp,
                                        formattedDate,
                                        token,
                                        ip);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Formatted Date: $formattedDate")),
                                );
                                try {
                                  final patientData =
                                      await LoginState.fetchPatientData(
                                          cardnumber, token, ip);
                                  Provider.of<PatientProvider>(context,
                                          listen: false)
                                      .patient = patientData;

                                  Navigator.pushNamed(
                                    context,
                                    "/welcome_page",
                                    arguments: patientData,
                                  );
                                } catch (e) {}
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "An error occurred: Unable to update try another dates")),
                                );
                              } finally {
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            }
                          : null,
                      child: isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text("Update"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
