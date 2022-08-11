import 'package:bmi_app/R/r.dart';
import 'package:flutter/material.dart';

class APPTextStyle {
  final TextStyle calculateTextStyle = const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  final TextStyle clockTextStyle = const TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  final TextStyle menuTextStyle = TextStyle(
    color: R.appColors.secondColor,
    fontSize: 10,
    overflow: TextOverflow.ellipsis,
  );

  final TextStyle labelTextStyle = TextStyle(
    fontSize: 18,
    color: R.appColors.secondColor,
  );
}
