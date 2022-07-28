import 'package:bmi_app/constants/constants.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final IconData icon;
  final String? title;

  const MenuButton({
    Key? key,
    this.onTap,
    required this.icon,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: title == args
              ? MaterialStateProperty.all(Colors.black)
              : MaterialStateProperty.all(Colors.transparent),
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
                  color: title == args ? Colors.white : secondColor),
            )
          ],
        ),
      ),
    );
  }
}
