// ignore_for_file: prefer_const_constructors, unused_element, deprecated_member_use, avoid_print

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
List<DateTime> availableDates = [
  DateTime.now().add(Duration(days: 1)),
  DateTime.now().add(Duration(days: 3)),
  DateTime.now().add(Duration(days: 5)),
];

class _CalendarState extends State<Calendar> {
  @override
  Widget build(BuildContext context) {
    print(WidgetsBinding.instance.window.locale.toString());
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: TableCalendar(
        locale: WidgetsBinding.instance.window.locale.toString()=='en'?'en':'am_ET',

        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        availableGestures: AvailableGestures.all,
calendarStyle: CalendarStyle(disabledTextStyle: ),
        calendarFormat: _calendarFormat,

        //
      )),
    );
  }
}
