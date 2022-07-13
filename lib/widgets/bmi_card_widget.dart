import 'package:flutter/material.dart';

class BMICardWidget extends StatelessWidget {
  final Widget child;
  final Color? color;

  const BMICardWidget({
    Key? key,
    required this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: child,
      ),
    );
  }
}
