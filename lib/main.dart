import 'package:climato/screens/HomePage.dart';
import 'package:climato/utlities/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      color: Colors.white,
      theme: defaultAppTheme,
      home: SafeArea(
        child: Scaffold(body: HomePage()),
      ),
    ),
  );
}
