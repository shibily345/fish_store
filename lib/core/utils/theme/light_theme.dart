import 'package:flutter/material.dart';


ThemeData lightTheme(BuildContext context) {
  return ThemeData(
      primaryColorLight: const Color.fromARGB(255, 221, 220, 220),
      primaryColor: const Color.fromARGB(255, 196, 124, 0),
      primarySwatch: Colors.amber,
      indicatorColor: const Color.fromARGB(255, 0, 0, 0),
      splashColor: const Color.fromARGB(255, 255, 240, 205),
      shadowColor: const Color.fromARGB(255, 233, 227, 194),
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      primaryColorDark: Colors.black,
      appBarTheme:
          const AppBarTheme(backgroundColor: Colors.transparent, elevation: 0)
      // textTheme: const TextTheme(
      //   labelLarge: lableTextStyle,
      //   labelMedium: lableTextStyle,
      //   labelSmall: lableTextStyle,
      //   bodyMedium: TextStyle(color: secondaryColor40LightTheme),
      // ),
      );
}
