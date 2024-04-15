import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.amber,
        brightness: Brightness.light,
      ),
      primaryColorLight: Color.fromARGB(255, 245, 208, 148),
      primaryColor: Color.fromARGB(255, 142, 90, 1),
      primarySwatch: Colors.amber,
      indicatorColor: const Color.fromARGB(255, 0, 0, 0),
      splashColor: Color.fromARGB(222, 242, 235, 224),
      shadowColor: const Color.fromARGB(255, 233, 227, 194),
      scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
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
