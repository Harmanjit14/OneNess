import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:oneness/models/authModel.dart';
import 'package:oneness/models/protest.dart';
import 'package:oneness/pages/navpages/page1.dart';

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

  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              iconData: Icons.home,
              title: "Home",
              onclick: () {
                final FancyBottomNavigationState fState =
                    bottomNavigationKey.currentState;
                fState.setPage(2);
              }),
          TabData(
            iconData: Icons.search,
            title: "Search",
            onclick: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PageOne(),
              ),
            ),
          ),
          TabData(iconData: Icons.shopping_cart, title: "Basket")
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
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
