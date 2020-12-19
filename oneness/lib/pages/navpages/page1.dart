import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oneness/models/authModel.dart';

class PageOne extends StatefulWidget {
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              style: GoogleFonts.poppins(
                  fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
