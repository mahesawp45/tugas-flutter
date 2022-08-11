import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData icon;
  final String? title;
  final MaterialStateProperty<Color>? bgColor;
  final BoxConstraints constraints;

  const MenuButton({
    Key? key,
    this.onTap,
    required this.icon,
    this.title,
    this.bgColor,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: bgColor,
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        onPressed: onTap,
        child: Padding(
          padding: EdgeInsets.all(constraints.maxWidth < 992 ? 4 : 10),
          child: Center(
              child: Icon(icon,
                  size: constraints.maxWidth < 992 ? 30 : 40,
                  color: Colors.white)),
        ),
      ),
    );
  }
}
