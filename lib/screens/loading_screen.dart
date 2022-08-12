import 'dart:async';

import 'package:bmi_app/routes/app_pages.dart';
import 'package:bmi_app/widgets/button/main_menu_button.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isFirst = true;

  @override
  void initState() {
    Timer.periodic(
      const Duration(milliseconds: 500),
      (timer) {
        setState(() {
          isFirst = !isFirst;
        });
      },
    );
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes.bmiResultScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedCrossFade(
                sizeCurve: Curves.linear,
                firstChild: const Padding(
                  padding: EdgeInsets.all(20),
                  child: MainMenuButton(size: 45),
                ),
                secondChild: const Padding(
                  padding: EdgeInsets.all(20),
                  child: MainMenuButton(size: 60),
                ),
                crossFadeState: isFirst
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 500),
              ),
              const SizedBox(height: 10),
              const Text(
                'Loading...',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
