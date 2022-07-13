import 'package:bmi_app/helpers/bmi_calculator.dart';
import 'package:flutter/material.dart';

import 'package:bmi_app/constants/constants.dart';
import 'package:bmi_app/routes/app_pages.dart';
import 'package:bmi_app/widgets/aritmathic_button_widget.dart';
import 'package:bmi_app/widgets/bmi_card_widget.dart';
import 'package:bmi_app/widgets/gender_widget.dart';
import 'package:bmi_app/widgets/measurement_widget.dart';

class BMIDataScreen extends StatefulWidget {
  const BMIDataScreen({Key? key}) : super(key: key);

  @override
  State<BMIDataScreen> createState() => _BMIDataScreenState();
}

class _BMIDataScreenState extends State<BMIDataScreen> {
  int height = 100;
  int weight = 50;
  double age = 20;
  bool isMale = false;
  bool isFemale = false;
  var gender = BMICalculator.fromBMIValue().gender;

  @override
  Widget build(BuildContext context) {
    final widthTombol = MediaQuery.of(context).size.width;
    final BMICalculator bmiCalculator =
        BMICalculator(height: height, weight: weight);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BMI CALCULATOR'),
      ),
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(flex: 1),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.red.shade900,
                    child: const Text('BMI'),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'BMI CALCULATOR APPS',
                    style: labelTextStyle,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Divider(color: primaryColorLighter, thickness: 2),
            MenuItem(
              icon: Icons.sports_gymnastics,
              text: 'Workout Challenge',
              tap: () {},
            ),
            MenuItem(
              icon: Icons.watch_later,
              text: 'Set Eat Time',
              tap: () {},
            ),
            MenuItem(
              icon: Icons.share,
              text: 'Share Us',
              tap: () {},
            ),
            MenuItem(
              icon: Icons.star,
              text: 'Rate Us',
              tap: () {},
            ),
            MenuItem(
              icon: Icons.settings,
              text: 'Settings',
              tap: () {},
            ),
            const Spacer(flex: 3),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                children: [
                  BMICardWidget(
                    child: GenderWidget(
                      borderColor:
                          gender == "male" ? Colors.red : Colors.transparent,
                      onTap: () {
                        setState(() {
                          gender = 'male';
                          isMale = true;
                          isFemale = false;
                        });
                      },
                      textGender: 'Male',
                      iconGender: Icons.male,
                    ),
                  ),
                  BMICardWidget(
                    child: GenderWidget(
                      borderColor:
                          gender == 'female' ? Colors.red : Colors.transparent,
                      onTap: () {
                        setState(() {
                          gender = 'female';
                          isFemale = true;
                          isMale = false;
                        });
                      },
                      textGender: 'Female',
                      iconGender: Icons.female,
                    ),
                  ),
                ],
              ),
            ),
          ),
          BMICardWidget(
            color: primaryColorDarker,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AritMathicButton(
                      aritmathicIcon: Icons.remove,
                      onTap: () {
                        if (height > 0) {
                          setState(() {
                            height--;
                          });
                        }
                      },
                      radius: 30,
                      splashColor: primaryColorDarker,
                      bgColor: primaryColorLighter,
                      iconColor: secondColor,
                    ),
                    const SizedBox(width: 10),
                    AritMathicButton(
                      aritmathicIcon: Icons.add,
                      onTap: () {
                        if (height < 250) {
                          setState(() {
                            height++;
                          });
                        }
                      },
                      radius: 30,
                      splashColor: primaryColorDarker,
                      bgColor: primaryColorLighter,
                      iconColor: secondColor,
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                Text(
                  'HEIGHT',
                  style: labelTextStyle.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${height.toInt()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 50,
                      ),
                    ),
                    Text(
                      'cm',
                      style: TextStyle(color: secondColor),
                    ),
                  ],
                ),
                Slider(
                  activeColor: Colors.white,
                  thumbColor: Colors.red.shade900,
                  max: 250,
                  min: 0,
                  value: height.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      height = value.toInt();
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                BMICardWidget(
                  color: primaryColorDarker,
                  child: MeaSurementWidget(
                    label: 'WEIGHT',
                    measureLabel: 'kg',
                    measure: weight,
                    button1: AritMathicButton(
                      bgColor: primaryColorLighter,
                      splashColor: primaryColorDarker,
                      iconColor: secondColor,
                      radius: 60,
                      aritmathicIcon: Icons.remove,
                      onTap: () {
                        if (weight > 0) {
                          setState(() {
                            weight--;
                          });
                        }
                      },
                    ),
                    button2: AritMathicButton(
                      bgColor: primaryColorLighter,
                      splashColor: primaryColorDarker,
                      iconColor: secondColor,
                      radius: 60,
                      aritmathicIcon: Icons.add,
                      onTap: () {
                        setState(() {
                          weight++;
                        });
                      },
                    ),
                    slider: Slider(
                      activeColor: Colors.white,
                      thumbColor: Colors.red.shade900,
                      max: 150,
                      min: 0,
                      value: weight.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          weight = value.toInt();
                        });
                      },
                    ),
                  ),
                ),
                BMICardWidget(
                  color: primaryColorDarker,
                  child: MeaSurementWidget(
                    label: 'AGE',
                    measureLabel: 'y.o',
                    button1: AritMathicButton(
                      bgColor: primaryColorLighter,
                      splashColor: primaryColorDarker,
                      iconColor: secondColor,
                      radius: 60,
                      aritmathicIcon: Icons.remove,
                      onTap: () {
                        if (age > 0) {
                          setState(() {
                            age--;
                          });
                        }
                      },
                    ),
                    button2: AritMathicButton(
                      bgColor: primaryColorLighter,
                      splashColor: primaryColorDarker,
                      iconColor: secondColor,
                      radius: 60,
                      aritmathicIcon: Icons.add,
                      onTap: () {
                        setState(() {
                          age++;
                        });
                      },
                    ),
                    measure: age,
                    slider: Slider(
                      activeColor: Colors.white,
                      thumbColor: Colors.red.shade900,
                      max: 150,
                      min: 0,
                      value: age.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (gender != null) {
                bmiCalculator.calculate();

                Navigator.pushNamed(
                  context,
                  Routes.bmiResultScreen,
                  arguments: {
                    "bmi": bmiCalculator.bmi!,
                    "isMale": isMale,
                    "isFemale": isFemale,
                  },
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Please select one of the gender, and try again!',
                      maxLines: 2,
                    ),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 2),
                    dismissDirection: DismissDirection.horizontal,
                    margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.08,
                        horizontal: 10),
                  ),
                );
              }
            },
            child: Container(
              color: Colors.red.shade900,
              height: 60,
              width: widthTombol,
              child: Center(
                child: Text(
                  'Calculate Your BMI',
                  style: calculateTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final GestureTapCallback tap;

  const MenuItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: tap,
      leading: Icon(
        icon,
        color: secondColor,
        size: 25,
      ),
      title: Text(
        text,
        style: labelTextStyle.copyWith(color: Colors.white, fontSize: 15),
      ),
    );
  }
}
