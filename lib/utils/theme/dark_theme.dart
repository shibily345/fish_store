import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColorLight: Colors.grey,
    primaryColorDark: const Color.fromARGB(255, 0, 0, 0),
    primaryColor: Colors.amber,
    primarySwatch: Colors.amber,
    indicatorColor: const Color.fromARGB(255, 255, 255, 255),
    splashColor: Color.fromARGB(249, 27, 27, 27),
    shadowColor: const Color.fromARGB(32, 131, 128, 128),
    scaffoldBackgroundColor: const Color.fromARGB(255, 42, 42, 42),
    // textTheme: const TextTheme(
    //   labelLarge: lableTextStyle,
    //   labelMedium: lableTextStyle,
    //   labelSmall: lableTextStyle,
    //   bodyMedium: TextStyle(color: secondaryColor40DarkTheme),
    // ),
  );
}
