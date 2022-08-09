import 'package:flutter/material.dart';

class AritMathicButton extends StatelessWidget {
  final IconData aritmathicIcon;
  final GestureTapCallback? onTap;
  final double radius;
  final Color splashColor;
  final Color bgColor;
  final Color iconColor;

  const AritMathicButton({
    Key? key,
    required this.aritmathicIcon,
    required this.onTap,
    required this.radius,
    required this.splashColor,
    required this.bgColor,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(100),
      color: bgColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(100),
        splashColor: splashColor,
        onTap: onTap,
        child: SizedBox(
          width: radius,
          height: radius,
          child: Icon(
            aritmathicIcon,
            color: iconColor,
            size: radius / 3,
          ),
        ),
      ),
    );
  }
}
