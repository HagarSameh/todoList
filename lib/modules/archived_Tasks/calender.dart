import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
class calender extends StatelessWidget {
  const calender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:TableCalendar(
        firstDay: DateTime.utc(2010,10,20),
        lastDay: DateTime.utc(2040,10,20),
        focusedDay: DateTime.now(),
      ),

    );
  }
}