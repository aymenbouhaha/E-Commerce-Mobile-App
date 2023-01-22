import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const kSpacingUnit = 10;

const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF80CBC4);
const kDarkAppBarColor = Color(0xFFFFC107);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);
final kTitleTextStyle = TextStyle(
    fontSize: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
    fontWeight: FontWeight.w600,
    fontFamily: 'SFProText',
    color: Color(0xFFF8BBD0));
final kTitleAppBarTextStyle = TextStyle(
    fontSize: ScreenUtil().setSp(kSpacingUnit.w * 2.3),
    fontWeight: FontWeight.bold,
    fontFamily: 'SFProText',
    color: Color(0xFF00695C));

final kCaptionTextStyle = TextStyle(
    fontSize: ScreenUtil().setSp(kSpacingUnit.w * 2.4),
    fontWeight: FontWeight.w100,
    fontFamily: 'SFProText',
    color: Color(0xFF8C9EFF));

final kButtonTextStyle = TextStyle(
  fontSize: ScreenUtil().setSp(kSpacingUnit.w * 2.5),
  fontWeight: FontWeight.w600,
  color: kDarkPrimaryColor,
);

final kDarkTheme = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Color(0xFFFF80AB)),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
      borderSide: BorderSide(width: 3, color: Colors.greenAccent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
      borderSide: BorderSide(width: 3, color: Colors.amberAccent),
    ),
  ),
  appBarTheme: AppBarTheme(color: kDarkAppBarColor),
  textTheme: const TextTheme(
      headline5: TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'SFProText'),
      bodyText1: TextStyle(
          fontSize: 15.0, fontWeight: FontWeight.bold, fontFamily: 'SFProText'),
      bodyText2: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'SFProText')),
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
        color: kLightSecondaryColor,
      ),
);

final kLightTheme = ThemeData(
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Color(0xFFFF80AB)),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
      borderSide: BorderSide(width: 3, color: Colors.greenAccent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(50.0)),
      borderSide: BorderSide(width: 3, color: Colors.amberAccent),
    ),
  ),
  appBarTheme: AppBarTheme(
      titleTextStyle: kTitleAppBarTextStyle, color: kDarkAppBarColor),
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  backgroundColor: kLightSecondaryColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
        color: kDarkSecondaryColor,
      ),
  textTheme: ThemeData.light().textTheme.apply(
        fontFamily: 'SFProText',
        bodyColor: kDarkSecondaryColor,
        displayColor: kDarkSecondaryColor,
      ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
);
