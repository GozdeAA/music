import 'package:flutter/material.dart';

//TODO renkler değişecek
class LightTheme {
  LightTheme({
    this.mainColor = const Color(0xff6109AF),
    this.white = const Color(0xffFFFFFF),
    this.darkerIconColor = const Color(0xff130023),
    this.onSecondary = const Color(0xff3b0951),
    this.borderColor = const Color(0xff130023),
    this.tertiary = const Color(0xff181A23),
    this.secondary = const Color(0xff30D5C8),
    this.lightBlue = const Color(0xff3BB4F4),
    this.inputColor = const Color(0xffF6F9FB),
    this.iconColor = const Color(0xff3E76FF),
    this.unselectedColor = const Color(0xffAFAFAF),
    this.errorColor = const Color(0xffef5350),
    this.hintColor = const Color(0xffD8EBFF),
    this.ontertiary = const Color(0xff27CC5A),
  });

  ///main orange
  final Color mainColor;
  final Color white;

  ///button dark grey / bg inline button / bg dark button
  final Color hintColor;

  ///error color
  final Color errorColor;

  //secondary
  final Color secondary;

  ///icon green
  final Color? ontertiary;

  ///bg bordered button / border color
  final Color? tertiary;

  ///bg gray button / color text gray
  Color onSecondary;

  ///border color
  Color? borderColor;

  ///textfield fill color
  final Color? inputColor;

  ///darker icon color
  final Color? darkerIconColor;

  final Color? iconColor;

  final Color unselectedColor;

  final Color? lightBlue;

  TextTheme txtTheme = ThemeData.light().textTheme;

  ThemeData get themeData {
    ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: white,
      onPrimary: mainColor,
      secondary: secondary,
      onSecondary: onSecondary,
      tertiary: tertiary,
      onTertiary: ontertiary,
      outline: borderColor,
      error: errorColor,
      onBackground: white,
      onSurface: mainColor,
      background: white,
      surface: mainColor,
      outlineVariant: inputColor,
      scrim: darkerIconColor,
      surfaceTint: lightBlue,
      onError: errorColor,
      onSurfaceVariant: iconColor,
    );

    var theme = ThemeData.from(
        textTheme: txtTheme.copyWith(
          labelSmall: TextStyle(color: darkerIconColor, fontFamily: "Open Sans",fontSize: 16),
          labelMedium: TextStyle(color: darkerIconColor,fontFamily: "Open Sans", fontSize: 16),
          labelLarge: TextStyle(color: darkerIconColor, fontSize: 16,fontFamily: "Open Sans", fontWeight: FontWeight.bold),
          bodySmall: TextStyle(color: darkerIconColor,fontFamily: "Open Sans", fontSize: 16),
          bodyLarge: TextStyle(color: darkerIconColor,fontFamily: "Open Sans", fontSize: 16),
          displayLarge: TextStyle(color: darkerIconColor,fontFamily: "Open Sans", fontSize: 17),
          displayMedium: TextStyle(color: darkerIconColor, fontFamily: "Open Sans",fontSize: 16),
          bodyMedium: TextStyle(color: darkerIconColor,fontFamily: "Open Sans", fontSize: 15),
          titleMedium: TextStyle(color: darkerIconColor,fontFamily: "Open Sans", fontSize: 16),
        ),
        colorScheme: colorScheme)
    // We can also add on some extra properties that ColorScheme seems to miss
        .copyWith(highlightColor: inputColor);
    return theme;
  }
}
