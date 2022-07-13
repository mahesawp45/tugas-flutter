import 'package:flutter/material.dart';

import '/constants/constants.dart';

class GenderWidget extends StatelessWidget {
  const GenderWidget({
    Key? key,
    required this.onTap,
    required this.iconGender,
    required this.textGender,
    required this.borderColor,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final IconData iconGender;
  final String textGender;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColorLighter,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        splashColor: primaryColorDarker,
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
                size: 80,
                color: Colors.white,
              ),
              Text(
                textGender,
                style: labelTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
