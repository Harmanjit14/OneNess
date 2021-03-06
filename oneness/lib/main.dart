import 'package:flutter/material.dart';
import 'package:oneness/pages/main_protest.dart';
import 'pages/auth.dart';
import 'pages/spash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OneNess',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "/": (context) => SplashScreen(),
        "/auth": (context) => Auth(),
        "/main": (context) => MainProtest(),
      },
      initialRoute: "/",
    );
  }
}
