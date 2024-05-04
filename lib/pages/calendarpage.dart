// ignore_for_file: prefer_const_constructors, unused_element, deprecated_member_use, avoid_print, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:final_year/providers/appointmentdays.dart';
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

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments as String?;

    if (arguments != null) {
      // Parse the string to DateTime
      _focusedDay = DateTime.parse(arguments);
    } else {
      _focusedDay = DateTime.now(); // Default focus if no argument is provided
    }
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
    List<String> enabledDates = List<String>.from(patient["days"]);
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Appointment"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime(2024, 1, 1),
              lastDay: DateTime(2025, 12, 31),
              focusedDay: _focusedDay,
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
                todayTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              onDaySelected: (selectedDay, focusedDay) {
                print("Selected day: $selectedDay");
              },
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Text("Change Appointment"),
                  ),
                  Center(
                      child:
                          Text("Initial Appointment : ${DateFormat('MM/dd/yyyy').format(_focusedDay)}"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  //   print(WidgetsBinding.instance.window.locale.toString());
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: SafeArea(

  //     child:  TableCalendar(
  //         // locale: WidgetsBinding.instance.window.locale.toString()=='en'?'en':'am_ET',

  //       firstDay: _appointmentDate!.toUtc(),
  //       lastDay: DateTime.utc(2030, 12, 31),
  //       focusedDay: _focusedDay,
  //       calendarFormat: _calendarFormat,
  //       selectedDayPredicate: (day) {
  //         return isSameDay(_selectedDay, day);
  //       },
  //       onDaySelected: (selectedDay, focusedDay) {
  //         setState(() {
  //           _selectedDay = selectedDay;
  //           _focusedDay = focusedDay;
  //         });
  //       },
  //      enabledDayPredicate: (day) {
  //           // Enable days starting from the selected appointment date
  //           if (_appointmentDate != null) {
  //             return !day.isBefore(_appointmentDate!);
  //           }
  //           return true; // By default, enable all days
  //         },

  //     ),

  //   ), floatingActionButton: FloatingActionButton(
  //       onPressed: () {
  //         // Set the appointment date and rebuild the widget
  //         setState(() {
  //           _appointmentDate = DateTime.now().subtract(Duration(days: 7)); // Example: 7 days before today
  //         });
  //       },
  //       child: Icon(Icons.add),
  //     ),);
  // }
}
