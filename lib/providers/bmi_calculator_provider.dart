import 'dart:math';

import 'package:bmi_app/R/constants/constants.dart';
import 'package:bmi_app/R/r.dart';
import 'package:flutter/material.dart';

class BMICalculatorProvider extends ChangeNotifier {
  int? height;
  int? weight;
  double? bmi;
  String? bmiCategory;
  String? bmiDescription;
  String? gender;
  Color? resultColor;
  List<Color> resultColors = [
    Colors.amber,
    Colors.yellow,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.brown,
  ];

  // BMICalculatorProvider({this.height, this.weight});
  // BMICalculatorProvider.fromBMIValue({this.bmi});

  /// Ini dipakai untuk mendapatkan hasil BMI = weigth / height dalam meter2
  double calculate({int? height, int? weight}) {
    double heightInMeter = height! / 100;
    bmi = weight! / pow(heightInMeter, 2);
    notifyListeners();
    return bmi!;
  }

  String determineBMICategory() {
    if (bmi! < 16.0) {
      bmiCategory = R.appStrings.underweightSevere;
      resultColor = resultColors[0];
    } else if (bmi! < 17.0) {
      bmiCategory = R.appStrings.underweightModerate;
      resultColor = resultColors[1];
    } else if (bmi! < 18.5) {
      bmiCategory = R.appStrings.underweightMild;
      resultColor = resultColors[1];
    } else if (bmi! < 25.0) {
      bmiCategory = R.appStrings.normal;
      resultColor = resultColors[2];
    } else if (bmi! < 30) {
      bmiCategory = R.appStrings.overweight;
      resultColor = resultColors[3];
    } else if (bmi! < 35) {
      bmiCategory = R.appStrings.obeseI;
      resultColor = resultColors[4];
    } else if (bmi! < 40) {
      bmiCategory = R.appStrings.obeseII;
      resultColor = resultColors[4];
    } else if (bmi! >= 40) {
      bmiCategory = R.appStrings.obeseIII;
      resultColor = resultColors[5];
    }

    notifyListeners();
    return bmiCategory!;
  }

  String getHealthRiskDescription() {
    switch (bmiCategory) {
      case underweightSevere:
      case underweightModerate:
      case underweightMild:
        bmiDescription = 'Possible nutritional deficiency and osteoporosis.';
        break;
      case normal:
        bmiDescription = 'Low risk (healthy range)';
        break;
      case overweight:
        bmiDescription =
            'Moderate risk of developing heart disease, high blood presure, stroke, diabetes mellitus';
        break;
      case obeseI:
      case obeseII:
      case obeseIII:
        bmiDescription =
            'High risk of developing heart disease, high blood pressure, stroke, diabetes mellitus. Metabolic Syndrome.';
        break;
    }

    notifyListeners();
    return bmiDescription!;
  }
}
