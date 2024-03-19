// ignore_for_file: prefer_const_constructors, unused_element, deprecated_member_use, avoid_print, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

CalendarFormat _calendarFormat = CalendarFormat.month;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _appointmentDate=DateTime.now();

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    print(WidgetsBinding.instance.window.locale.toString());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          
      child:  TableCalendar(
          locale: WidgetsBinding.instance.window.locale.toString()=='en'?'en':'am_ET',
          
        firstDay: _appointmentDate!.toUtc(),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
       enabledDayPredicate: (day) {
            // Enable days starting from the selected appointment date
            if (_appointmentDate != null) {
              return !day.isBefore(_appointmentDate!);
            }
            return true; // By default, enable all days
          },
        
      ),
      
     
    ), floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Set the appointment date and rebuild the widget
          setState(() {
            _appointmentDate = DateTime.now().subtract(Duration(days: 7)); // Example: 7 days before today
          });
        },
        child: Icon(Icons.add),
      ),);
  }
}
