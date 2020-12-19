import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oneness/models/authModel.dart';
import 'package:oneness/models/distress.dart';
import 'package:oneness/models/protest.dart';
import 'package:oneness/pages/navpages/page1.dart';
import 'package:oneness/pages/navpages/page2.dart';
import 'package:oneness/pages/navpages/page3.dart';
import 'package:oneness/pages/navpages/page4.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

String id;

class HomeNavigation extends StatefulWidget {
  HomeNavigation(String temp) {
    id = temp;
  }
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int currentPage = 0;
  int index = 0;

  Widget getPage() {
    switch (index) {
      case 0:
        return PageOne();
        break;
      case 1:
        return PageTwo();
        break;
      case 2:
        return PageThree();
        break;
      case 3:
        return PageFour();
        break;
      default:
        return PageOne();
    }
  }

  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
           Alert(
              context: context,
              type: AlertType.warning,
              title: "Emmergency Alert!",
              desc: "This will alert Police Services that you need help!",
              buttons: [
                DialogButton(
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  onPressed: () {
                    sendDistress();
                    Navigator.pop(context);
                    setState(() {});
                  },
                  color: Color.fromRGBO(0, 179, 134, 1.0),
                ),
              ],
            ).show();
          
        },
        child: Icon(Icons.notification_important),
      ),
      body: getPage(),
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                finName = "";
                token = "";
                Navigator.pushNamedAndRemoveUntil(
                    context, "/", (route) => false);
              })
        ],
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
            iconData: FontAwesomeIcons.home,
            title: "Home",
          ),
          TabData(
            iconData: FontAwesomeIcons.handsHelping,
            title: "Donations",
          ),
          TabData(
            iconData: FontAwesomeIcons.breadSlice,
            title: "Resources",
          ),
          TabData(
            iconData: FontAwesomeIcons.mapMarked,
            title: "Home",
          ),
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          index = position;
          setState(() {
            currentPage = position;
          });
        },
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[Text("Hello"), Text("World")],
        ),
      ),
    );
  }
}
