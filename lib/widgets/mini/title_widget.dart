import 'package:bmi_app/R/r.dart';
import 'package:flutter/material.dart';

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
      style: R.appTextStyle.clockTextStyle
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
