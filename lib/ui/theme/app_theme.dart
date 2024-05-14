import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromARGB(255, 153, 0, 255),
    secondaryHeaderColor: Color.fromARGB(255, 153, 0, 255),
    scaffoldBackgroundColor: const Color.fromARGB(255, 242, 245, 255),
    fontFamily: 'Poppins',
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 72.0, fontFamily: 'Poppins', fontWeight: FontWeight.bold),
      headline6: TextStyle(
          fontSize: 36.0, fontFamily: 'Poppins', fontStyle: FontStyle.normal),
      bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Poppins'),
    ),
    // -> Tema do checkbox
    checkboxTheme:
        CheckboxThemeData(fillColor: MaterialStateColor.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return const Color.fromARGB(255, 153, 0, 255);
      } else {
        return Colors.black;
      }
    })));
