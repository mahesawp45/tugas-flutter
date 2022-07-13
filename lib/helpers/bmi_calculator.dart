import 'dart:math';
import 'package:bmi_app/constants/constants.dart';
import 'package:flutter/material.dart';

class BMICalculator {
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

  BMICalculator({required this.height, required this.weight});
  BMICalculator.fromBMIValue({this.bmi});

  /// Ini dipakai untuk mendapatkan hasil BMI = weigth / height dalam meter2
  double calculate() {
    double heightInMeter = height! / 100;
    bmi = weight! / pow(heightInMeter, 2);
    return bmi!;
  }

  String determineBMICategory() {
    if (bmi! < 16.0) {
      bmiCategory = underweightSevere;
      resultColor = resultColors[0];
    } else if (bmi! < 17.0) {
      bmiCategory = underweightModerate;
      resultColor = resultColors[1];
    } else if (bmi! < 18.5) {
      bmiCategory = underweightMild;
      resultColor = resultColors[1];
    } else if (bmi! < 25.0) {
      bmiCategory = normal;
      resultColor = resultColors[2];
    } else if (bmi! < 30) {
      bmiCategory = overweight;
      resultColor = resultColors[3];
    } else if (bmi! < 35) {
      bmiCategory = obeseI;
      resultColor = resultColors[4];
    } else if (bmi! < 40) {
      bmiCategory = obeseII;
      resultColor = resultColors[4];
    } else if (bmi! >= 40) {
      bmiCategory = obeseIII;
      resultColor = resultColors[5];
    }

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

    return bmiDescription!;
  }
}
