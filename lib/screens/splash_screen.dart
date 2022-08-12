import 'dart:async';

import 'package:bmi_app/routes/app_pages.dart';
import 'package:bmi_app/widgets/button/main_menu_button.dart';
import 'package:bmi_app/widgets/mini/title_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirst = false;

  @override
  void initState() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          isFirst = !isFirst;
        });
      },
    );
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, Routes.bmiDataScreen);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const SizedBox(
        height: 100,
        width: double.infinity,
        child: Center(
          child: Text(
            'Tugas IDCAMP 😘 | Flutter',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey,
            ),
          ),
        ),
      ),
      body: Center(
        child: Expanded(
          child: SizedBox(
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedAlign(
                  curve: Curves.easeIn,
                  heightFactor: 2,
                  widthFactor: 15,
                  alignment:
                      isFirst ? Alignment.centerLeft : Alignment.centerRight,
                  duration: const Duration(milliseconds: 500),
                  child: const MainMenuButton(size: 20),
                ),
                const TitleWidget(title: 'BMI CALCULATOR', fontSize: 20),
                AnimatedAlign(
                  curve: Curves.easeIn,
                  heightFactor: 2,
                  widthFactor: 15,
                  alignment:
                      isFirst ? Alignment.centerRight : Alignment.centerLeft,
                  duration: const Duration(milliseconds: 500),
                  child: const MainMenuButton(size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
