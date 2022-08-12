import 'package:bmi_app/R/r.dart';
import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkTheme
            ? R.appColors.primaryColor
            : const Color.fromARGB(255, 121, 0, 0),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: isDarkTheme ? R.appColors.primaryColor : Colors.white,
      ),
      iconTheme: IconThemeData(
          color: isDarkTheme ? Colors.white : R.appColors.primaryColor),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent),
      scaffoldBackgroundColor: isDarkTheme
          ? R.appColors.primaryColor
          : const Color.fromARGB(255, 121, 0, 0),
      primaryColor: isDarkTheme ? R.appColors.primaryColor : Colors.white,
      backgroundColor:
          isDarkTheme ? R.appColors.primaryColor : const Color(0xffF1F5FB),
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor:
          isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor:
          isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }
}
