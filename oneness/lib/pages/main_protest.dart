import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MainProtest extends StatefulWidget {
  @override
  _MainProtestState createState() => _MainProtestState();
}

class _MainProtestState extends State<MainProtest> {
  int dropVal = 0;
  int stateBut = 0;

  Widget logChild() {
    switch (stateBut) {
      case 0:
        {
          return Text(
            "Participate!",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 20, color: Colors.white)),
          );
        }
        break;
      case 1:
        {
          return SpinKitDoubleBounce(
            color: Colors.white,
            size: 30.0,
          );
        }
        break;
      case 2:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.checkCircle,
                color: Colors.white,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "Success",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          );
        }
        break;
      case 3:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.timesCircle,
                color: Colors.white,
              ),
              SizedBox(
                width: 7,
              ),
              Text(
                "Check Credentials!",
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ],
          );
        }
        break;
      default:
        {
          return Text(
            "Continue",
            style: GoogleFonts.poppins(
                textStyle: TextStyle(fontSize: 20, color: Colors.white)),
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                child: Image.asset("people2.gif"),
              ),
            ),
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          blurRadius: 3.0,
                        ),
                      ],
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(40)),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  child: DropdownButton(
                    icon: Icon(FontAwesomeIcons.angleDown),
                    iconSize: 27,
                    iconEnabledColor: Colors.black,
                    hint: Text("Select one to start!"),
                    isDense: false,
                    style:
                        GoogleFonts.poppins(fontSize: 25, color: Colors.black),
                    underline: SizedBox(),
                    elevation: 0,
                    dropdownColor: Colors.grey[200],
                    value: dropVal,
                    items: [
                      DropdownMenuItem(
                        child: Container(child: Text("Farmers")),
                        value: 0,
                        onTap: () {
                          setState(() {});
                        },
                      ),
                      DropdownMenuItem(
                        child: Text("Farmers 2"),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        child: Text("Farmers 3"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("Farmers 4"),
                        value: 2,
                      )
                    ],
                    onChanged: (int value) {
                      dropVal = value;
                      setState(() {});
                    },
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      new BoxShadow(
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.fromLTRB(20, 15, 20, 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: RaisedButton(
                      padding: EdgeInsets.all(15),
                      onPressed: () {},
                      //  () async {
                      //   stateBut = 1;
                      //   setState(() {});
                      //   int temp = 0; //await getToken();
                      //   if (temp == 1) {
                      //     Timer(Duration(seconds: 2), () {
                      //       stateBut = 2;
                      //       setState(() {});
                      //     });
                      //     Timer(Duration(seconds: 3), () {
                      //       password = "";
                      //       Navigator.pushReplacementNamed(context, "/nav");
                      //     });
                      //   } else {
                      //     Timer(Duration(seconds: 2), () {
                      //       stateBut = 3;
                      //       setState(() {});
                      //     });
                      //     Timer(Duration(seconds: 4), () {
                      //       stateBut = 0;
                      //       setState(() {});
                      //     });
                      //   }
                      // },
                      child: logChild(),
                      color: Colors.brown,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
