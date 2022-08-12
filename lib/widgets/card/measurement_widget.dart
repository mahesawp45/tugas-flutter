import 'package:bmi_app/R/r.dart';
import 'package:flutter/material.dart';

class MeaSurementWidget extends StatelessWidget {
  final Widget button1;
  final Widget button2;
  final num measure;
  final String label;
  final String measureLabel;
  final Widget slider;
  final double sizelabel;
  final double sizeMeasure;
  final double centerSpace;
  final double sideSpace;

  const MeaSurementWidget({
    Key? key,
    required this.button1,
    required this.button2,
    required this.measure,
    required this.label,
    required this.measureLabel,
    required this.slider,
    required this.sizelabel,
    required this.sizeMeasure,
    required this.centerSpace,
    required this.sideSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: sideSpace),
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: R.appTextStyle.labelTextStyle
                .copyWith(fontSize: sizelabel * 0.8),
          ),
        ),
        SizedBox(height: centerSpace),
        Expanded(
          flex: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${measure.toInt()}',
                style: TextStyle(
                  fontSize: sizeMeasure,
                  color: Colors.white,
                ),
              ),
              Text(
                measureLabel,
                style: R.appTextStyle.labelTextStyle.copyWith(fontSize: 12),
              ),
            ],
          ),
        ),
        slider,
        Expanded(
          flex: 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [button1, button2],
          ),
        ),
        SizedBox(height: sideSpace),
      ],
    );
  }
}
