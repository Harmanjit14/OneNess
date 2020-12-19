import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainProtest extends StatefulWidget {
  @override
  _MainProtestState createState() => _MainProtestState();
}

class _MainProtestState extends State<MainProtest> {
  int dropVal = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
        title: Text(
          "Choose your Protest",
          style: GoogleFonts.poppins(
            letterSpacing: -0.75,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: DropdownButton(
                icon: Icon(Icons.ac_unit),
                dropdownColor: Colors.green,
                value: dropVal,
                items: [
                  DropdownMenuItem(
                    child: Text("Farmers"),
                    value: 0,
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  DropdownMenuItem(
                    child: Text("Farmers 2"),
                    value: 3,
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  DropdownMenuItem(
                    child: Text("Farmers 3"),
                    value: 1,
                    onTap: () {
                      setState(() {});
                    },
                  ),
                  DropdownMenuItem(
                    child: Text("Farmers 4"),
                    value: 2,
                    onTap: () {
                      setState(() {});
                    },
                  )
                ],
                onChanged: (int value) {
                  dropVal = value;
                  setState(() {});
                },
              ),
            ),
            Container(
              child: Image.asset("people2.gif"),
            )
          ],
        ),
      ),
    );
  }
}
