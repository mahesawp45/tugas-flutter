import 'package:bmi_app/args/args_per_screen.dart';
import 'package:bmi_app/helpers/bmi_calculator.dart';
import 'package:bmi_app/widgets/main_menu_button.dart';
import 'package:bmi_app/widgets/menu_button_widget.dart';
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
  late int height;
  late int weight;
  late double age;
  late bool isMale;
  late bool isFemale = false;
  var gender;

  @override
  void initState() {
    height = 100;
    weight = 50;
    age = 20;
    isFemale = false;
    isMale = false;
    gender = BMICalculator.fromBMIValue().gender;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthTombol = MediaQuery.of(context).size.width;
    final BMICalculator bmiCalculator =
        BMICalculator(height: height, weight: weight);
    var paddingTop = MediaQuery.of(context).padding.top;

    var spacerMenu = MediaQuery.of(context).size.height * 0.15;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: paddingTop + 10),
                const MainMenuButton(),
                SizedBox(height: spacerMenu),
                MenuButton(
                  icon: Icons.sports_gymnastics,
                  title: Args.challange,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.challangeScreen,
                      arguments: Args.challange,
                    );
                  },
                ),
                MenuButton(
                  icon: Icons.watch_later_outlined,
                  title: Args.eatTime,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      Routes.setEatScreen,
                      arguments: Args.eatTime,
                    );
                  },
                ),
                MenuButton(
                  icon: Icons.star,
                  title: Args.rateUs,
                  onTap: () {},
                ),
                MenuButton(
                  icon: Icons.share,
                  title: Args.shareUs,
                  onTap: () {},
                ),
                MenuButton(
                  icon: Icons.settings,
                  title: Args.settings,
                  onTap: () {},
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
          VerticalDivider(color: secondColor, width: 2),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: paddingTop),
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 10),
                  child: TitleWidget(title: 'BMI Calculator'),
                ),
                Expanded(
                  child: Row(
                    children: [
                      BMICardWidget(
                        child: GenderWidget(
                          borderColor: gender == "male"
                              ? Colors.red
                              : Colors.transparent,
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
                          borderColor: gender == 'female'
                              ? Colors.red
                              : Colors.transparent,
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
                            radius: 50,
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
                            radius: 50,
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
                            radius: 50,
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
                            radius: 50,
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
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
                                vertical:
                                    MediaQuery.of(context).size.height * 0.08,
                                horizontal: 10),
                          ),
                        );
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.shade900,
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
