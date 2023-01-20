import 'package:flutter/material.dart';
import 'package:testprofile/screens/shared/profile_screen.dart';
import './screens/constants/constants.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
      theme:kDarkTheme,
    );
  }
}