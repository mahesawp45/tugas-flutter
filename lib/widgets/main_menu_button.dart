import 'package:flutter/material.dart';

class MainMenuButton extends StatelessWidget {
  const MainMenuButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.red.shade800,
          boxShadow: [
            BoxShadow(
              color: Colors.red.shade500,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 0),
            )
          ]),
    );
  }
}
