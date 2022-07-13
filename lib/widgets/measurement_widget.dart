import 'package:flutter/material.dart';

import 'package:bmi_app/constants/constants.dart';

class MeaSurementWidget extends StatelessWidget {
  final Widget button1;
  final Widget button2;
  final num measure;
  final String label;
  final String measureLabel;
  final Widget slider;

  const MeaSurementWidget({
    Key? key,
    required this.button1,
    required this.button2,
    required this.measure,
    required this.label,
    required this.measureLabel,
    required this.slider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 2),
        Text(
          label,
          style: labelTextStyle,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${measure.toInt()}',
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            Text(
              measureLabel,
              style: labelTextStyle.copyWith(fontSize: 12),
            ),
          ],
        ),
        slider,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [button1, button2],
        ),
        const SizedBox(height: 2),
      ],
    );
  }
}
