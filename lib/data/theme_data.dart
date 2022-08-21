import 'package:flutter/material.dart';

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [const Color(0xFF6448FE), const Color(0xFF5FC6FF)];
  static List<Color> sunset = [
    const Color(0xFFFE6197),
    const Color(0xFFFFB463)
  ];
  static List<Color> sea = [const Color(0xFF61A3FE), const Color(0xFF63FFD5)];
  static List<Color> mango = [const Color(0xFFFFA738), const Color(0xFFFFE130)];
  static List<Color> fire = [const Color(0xFFFF5DCD), const Color(0xFFFF8484)];
  static List<Color> leaf = [
    const Color.fromARGB(255, 28, 152, 6),
    const Color.fromARGB(255, 0, 237, 43)
  ];
}

class GradientTemplate {
  static List<String> colorName = [
    'Sky',
    'Sunset',
    'Sea',
    'Mango',
    'Fire',
    'Leaf'
  ];

  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
    GradientColors(GradientColors.leaf),
  ];
}
