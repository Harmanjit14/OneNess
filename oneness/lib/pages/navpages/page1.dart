import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oneness/models/authModel.dart';
import 'package:table_calendar/table_calendar.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  CalendarController _calendarController;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Text(
                "Welcome back",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                finName,
                style: GoogleFonts.poppins(shadows: <Shadow>[
                  Shadow(
                    offset: Offset(0.5, 0.5),
                    blurRadius: 1.5,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ], fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: TableCalendar(
                locale: "en_US",
                onDaySelected: (day, events, holidays) {},
                // events: periodDays,
                // holidays: exerciseDays,
                calendarController: _calendarController,
                calendarStyle: CalendarStyle(
                  holidayStyle:
                      TextStyle(color: Colors.green[700], fontSize: 20),
                  weekendStyle: TextStyle(color: Colors.black),
                  selectedColor: Colors.blue[900],
                  todayColor: Colors.blue,
                  markersColor: Colors.pink,
                  outsideDaysVisible: false,
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
