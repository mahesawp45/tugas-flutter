import 'package:flutter/material.dart';

import 'package:bmi_app/R/r.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final double? blurRadius;
  final double? fontSize;

  const TitleWidget({
    Key? key,
    required this.title,
    this.blurRadius,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: R.appTextStyle.clockTextStyle.copyWith(
          fontSize: fontSize ?? 34,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: blurRadius ?? 15,
              offset: const Offset(0, 0),
              color: Colors.red,
            )
          ]),
    );
  }
}
