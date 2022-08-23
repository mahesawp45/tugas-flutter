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
      iconTheme: const IconThemeData(color: Colors.white),
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: Colors.transparent),
      scaffoldBackgroundColor: isDarkTheme
          ? R.appColors.primaryColor
          : const Color.fromARGB(255, 121, 0, 0),
      primaryColor: isDarkTheme ? R.appColors.primaryColor : Colors.white,
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? const Color(0xff280C0B) : const Color(0xffCBDCF8),
      highlightColor: isDarkTheme ? const Color(0xff372901) : Colors.redAccent,
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : Colors.redAccent,
      focusColor: isDarkTheme ? const Color(0xff0B2512) : Colors.red.shade900,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.white : Colors.black),
    );
  }
}
