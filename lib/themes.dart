import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var appTheme = ThemeData(
    fontFamily: GoogleFonts.nunitoSans().fontFamily,
    brightness: Brightness.dark,
    textTheme: const TextTheme(
      bodyText1: TextStyle(fontSize: 18),
      bodyText2: TextStyle(fontSize: 16),
      headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
      headline2: TextStyle(fontSize: 20),
      subtitle1: TextStyle(fontSize: 14, color: Colors.white30),
      button: TextStyle(
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
      ),
    ));
