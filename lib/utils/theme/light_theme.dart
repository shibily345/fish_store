import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primaryColorLight: Color.fromARGB(255, 119, 119, 119),
    primaryColor: Colors.black,
    primarySwatch: Colors.amber,
    indicatorColor: const Color.fromARGB(255, 0, 0, 0),
    splashColor: Color(0xFFFFC436),
    shadowColor: const Color.fromARGB(32, 131, 128, 128),
    scaffoldBackgroundColor: Color.fromARGB(255, 255, 248, 221),
    // textTheme: const TextTheme(
    //   labelLarge: lableTextStyle,
    //   labelMedium: lableTextStyle,
    //   labelSmall: lableTextStyle,
    //   bodyMedium: TextStyle(color: secondaryColor40LightTheme),
    // ),
  );
}
