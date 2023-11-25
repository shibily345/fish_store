import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
      primaryColorLight: Color.fromARGB(255, 119, 119, 119),
      primaryColor: Color.fromARGB(255, 196, 124, 0),
      primarySwatch: Colors.amber,
      indicatorColor: const Color.fromARGB(255, 0, 0, 0),
      splashColor: Color.fromARGB(255, 255, 240, 205),
      shadowColor: Color.fromARGB(255, 233, 227, 194),
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      appBarTheme:
          AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)
      // textTheme: const TextTheme(
      //   labelLarge: lableTextStyle,
      //   labelMedium: lableTextStyle,
      //   labelSmall: lableTextStyle,
      //   bodyMedium: TextStyle(color: secondaryColor40LightTheme),
      // ),
      );
}
