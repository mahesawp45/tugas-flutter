import 'package:flutter/material.dart';

Color primaryColor = const Color(0xff0A0E21);
Color primaryColorLighter = const Color.fromARGB(255, 18, 23, 52);
Color primaryColorDarker = const Color.fromARGB(255, 7, 10, 24);
Color secondColor = const Color(0xff8d8e98);
TextStyle labelTextStyle = TextStyle(
  fontSize: 18,
  color: secondColor,
);

TextStyle calculateTextStyle = const TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

TextStyle clockTextStyle = const TextStyle(
  color: Colors.white,
  fontSize: 20,
);

TextStyle menuTextStyle = TextStyle(
  color: secondColor,
  fontSize: 10,
  overflow: TextOverflow.ellipsis,
);

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: clockTextStyle
          .copyWith(fontSize: 34, fontWeight: FontWeight.bold, shadows: [
        const Shadow(
          blurRadius: 15,
          offset: Offset(0, 0),
          color: Colors.red,
        )
      ]),
    );
  }
}

const String underweightSevere = "Underweight (Severe thinness)";
const String underweightModerate = "Underweight (Severe Moderate)";
const String underweightMild = "Underweight (Severe Mild)";
const String normal = "Normal";
const String overweight = "Overweight";
const String obeseI = "Obese (Class I)";
const String obeseII = "Obese (Class II)";
const String obeseIII = "Obese (Class III)";
