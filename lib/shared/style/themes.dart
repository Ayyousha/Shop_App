

// Light Theme
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moon/shared/style/colors.dart';

ThemeData LightTheme = ThemeData(
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontFamily:'pretty1',
      fontWeight: FontWeight.w200,
      fontSize: 15,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w100,
      color: Colors.black,
    ),
  ),
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleSpacing: 15,
    titleTextStyle: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      fontFamily:'pretty1',
      color: Colors.black,
    ),
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
      fontFamily:'pretty1',
      fontWeight: FontWeight.bold,
    ),
  ),
  fontFamily:'pretty1',
);

// Dark Theme
ThemeData DarkTheme = ThemeData(
  cardColor: HexColor("#393939"),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      // fontFamily:'pretty',
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      color: Colors.grey,
    ),
    subtitle1: TextStyle(
      color: Colors.white,
    ),
    subtitle2: TextStyle(
      color: Colors.white,
    ),
  ),
  scaffoldBackgroundColor: HexColor("#393939"),
  primarySwatch: defaultColor,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      // fontFamily:'pretty',
      color: Colors.white,
    ),
    titleSpacing: 15,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: HexColor("#393939"),
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor("#393939"),
    elevation: 0.0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor("#393939"),
    selectedItemColor: defaultColor,
    unselectedItemColor: Colors.grey,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: TextStyle(
      // fontFamily:'pretty',
      fontWeight: FontWeight.bold,
    ),
  ),
  // fontFamily:'pretty',
);