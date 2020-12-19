import 'package:flutter/material.dart';

String id;

class HomeNavigation extends StatefulWidget {
  HomeNavigation(String temp) {
    id = temp;
  }
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
    );
  }
}
