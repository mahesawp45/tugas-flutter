import 'package:bmi_app/R/r.dart';
import 'package:flutter/material.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    Key? key,
    required this.onTap,
    required this.iconGender,
    required this.textGender,
    required this.borderColor,
    required this.iconSize,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final IconData iconGender;
  final String textGender;
  final Color borderColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: R.appColors.primaryColorLighter,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: R.appColors.primaryColorDarker,
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 2, color: borderColor),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconGender,
                size: iconSize,
                color: Colors.white,
              ),
              Text(
                textGender,
                style: R.appTextStyle.labelTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
