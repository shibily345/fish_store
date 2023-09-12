import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    primaryColorDark: const Color.fromARGB(255, 0, 0, 0),
    primaryColor: Colors.amber,
    primarySwatch: Colors.amber,
    indicatorColor: const Color.fromARGB(255, 255, 255, 255),
    splashColor: const Color.fromARGB(79, 0, 0, 0),
    shadowColor: const Color.fromARGB(32, 131, 128, 128),
    scaffoldBackgroundColor: const Color.fromARGB(255, 42, 42, 42),
    // textTheme: const TextTheme(
    //   labelLarge: lableTextStyle,
    //   labelMedium: lableTextStyle,
    //   labelSmall: lableTextStyle,
    //   bodyMedium: TextStyle(color: secondaryColor40DarkTheme),
    // ),

    appBarTheme: const AppBarTheme(
      centerTitle: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      toolbarTextStyle: TextStyle(color: textColorDarkTheme),
    ),
    // inputDecorationTheme: const InputDecorationTheme(
    //   contentPadding: EdgeInsets.symmetric(horizontal: defaultPadding),
    //   fillColor: secondaryColor5DarkTheme,
    //   filled: true,
    //   border: DarkThemeOutlineInputBorder,
    //   enabledBorder: DarkThemeOutlineInputBorder,
    //   focusedBorder: DarkThemeOutlineInputBorder,
    //   disabledBorder: DarkThemeOutlineInputBorder,
    // ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        minimumSize: const Size(double.infinity, 48),
        shape: const StadiumBorder(),
        backgroundColor: primaryColor,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: textColorDarkTheme),
    dividerColor: secondaryColor5DarkTheme,
  );
}

const OutlineInputBorder DarkThemeOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide.none,
);

const lableTextStyle = TextStyle(color: secondaryColor20DarkTheme);
