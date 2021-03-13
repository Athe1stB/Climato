import 'package:flutter/material.dart';

ThemeData defaultAppTheme = ThemeData(
  iconTheme: IconThemeData(color: Colors.white, size: 30),
  primaryColor: Color(0xFF2152D1),
  backgroundColor: Colors.white,
  accentColor: Color(0xFFE9EEFA),
  scaffoldBackgroundColor: Colors.white,
  cardColor: Color(0xFFE9EEFA),
  hintColor: Colors.grey,
  cardTheme: CardTheme(
    color: Color(0xFFE9EEFA),
    elevation: 3.0,
  ),
);

TextStyle styleBold = TextStyle(
  color: Color(0xFF2152D1),
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle styleDarkGrayBold = TextStyle(
  color: Color(0xFF2152D1),
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldWhiteLarge = TextStyle(
  color: Colors.white,
  fontSize: 70,
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldBlack = TextStyle(
  color: Colors.black,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldBlackMedium = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldGrayMedium = TextStyle(
  color: Colors.black54,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

TextStyle styleBoldWhite = TextStyle(
  color: Colors.white,
  fontFamily: 'Kanit',
  fontSize: 24,
  letterSpacing: 2,
  fontWeight: FontWeight.bold,
);

TextStyle subHead = TextStyle(
  color: Colors.blue,
  fontSize: 20,
);
TextStyle normal = TextStyle(
  color: Colors.black,
  fontSize: 20,
);

TextStyle elementwhite = TextStyle(
  color: Colors.white,
  fontSize: 16,
);

TextStyle elementgray = TextStyle(
  color: Colors.white54,
  fontSize: 16,
);

class Constants {}
