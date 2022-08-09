import 'package:bmi_app/constants/constants.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData icon;
  final String? title;
  final MaterialStateProperty<Color>? bgColor;

  const MenuButton({
    Key? key,
    this.onTap,
    required this.icon,
    this.title,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: bgColor,
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
              ),
            ),
          ),
        ),
        onPressed: onTap,
        child: Column(
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 5),
            Text(
              title ?? '',
              style: menuTextStyle.copyWith(
                  color: title != null ? Colors.white : secondColor),
            )
          ],
        ),
      ),
    );
  }
}
