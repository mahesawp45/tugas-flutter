import 'package:bmi_app/args/args_per_screen.dart';
import 'package:bmi_app/helpers/bmi_calculator.dart';
import 'package:bmi_app/screens/sub_page/add_eat_alarm.dart';
import 'package:bmi_app/screens/sub_page/challenge_screen.dart';
import 'package:bmi_app/screens/sub_page/set_eat_time_screen.dart';
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

  int index = 0;
  final PageController _pageController = PageController();

  String? title;

  @override
  void initState() {
    height = 100;
    weight = 50;
    age = 20;
    isFemale = false;
    isMale = false;
    gender = BMICalculator.fromBMIValue().gender;
    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   setState(() {});
    // });
    super.initState();
  }

  @override
  void dispose() {
    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   setState(() {});
    // });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthTombol = MediaQuery.of(context).size.width;
    final BMICalculator bmiCalculator =
        BMICalculator(height: height, weight: weight);
    var paddingTop = MediaQuery.of(context).padding.top;

    var spacerMenu = MediaQuery.of(context).size.height * 0.1;

    return Scaffold(
      body: LayoutBuilder(builder: (context, constraint) {
        return Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildSideMenu(
                paddingTop,
                spacerMenu,
                context,
                constraint,
                index: index,
                pageController: _pageController,
              ),
            ),
            VerticalDivider(color: secondColor, width: 2),
            Expanded(
              flex: constraint.maxWidth < 992 ? 4 : 7,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: _pageController,
                children: [
                  _buildHomeScreen(
                    paddingTop,
                    bmiCalculator,
                    constraint,
                    context,
                    widthTombol,
                  ),
                  const ChallangeScreen(
                    title: 'Challange',
                  ),
                  const SetEatTimeScreen(
                    title: 'Eat Time',
                  ),
                  const AddEatAlarmScreen(
                    title: 'Set Alarm',
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Container _buildSideMenu(double paddingTop, double spacerMenu,
      BuildContext context, BoxConstraints constraint,
      {required PageController pageController, required int index}) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: paddingTop + (constraint.maxWidth < 992 ? 10 : 20)),
          GestureDetector(
            child: const MainMenuButton(),
            onTap: () {
              index = 0;
              title = 'BMI Calculator';
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              setState(() {});
            },
          ),
          SizedBox(height: spacerMenu),
          MenuButton(
            bgColor: title == 'Challange'
                ? MaterialStateProperty.all(Colors.black)
                : MaterialStateProperty.all(Colors.transparent),
            icon: Icons.sports_gymnastics,
            title: 'Challange',
            onTap: () {
              index = 1;
              title = 'Challange';
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              setState(() {});
            },
          ),
          MenuButton(
            bgColor: title == 'Eat Time'
                ? MaterialStateProperty.all(Colors.black)
                : MaterialStateProperty.all(Colors.transparent),
            icon: Icons.watch_later_outlined,
            title: 'Eat Time',
            onTap: () {
              index = 2;
              title = 'Eat Time';
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              setState(() {});
            },
          ),
          MenuButton(
            bgColor: title == 'Set Alarm'
                ? MaterialStateProperty.all(Colors.black)
                : MaterialStateProperty.all(Colors.transparent),
            icon: Icons.food_bank_outlined,
            title: 'Set Alarm',
            onTap: () {
              index = 3;
              title = 'Set Alarm';
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut);
              setState(() {});
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
            flex: 5,
          ),
        ],
      ),
    );
  }

  _buildHomeScreen(double paddingTop, BMICalculator bmiCalculator,
      BoxConstraints constraint, BuildContext context, double widthTombol) {
    return Expanded(
      child: Container(
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
                      iconSize: constraint.maxWidth < 992 ? 80 : 60,
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
                      iconSize: constraint.maxWidth < 992 ? 80 : 60,
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
                      SizedBox(width: constraint.maxWidth < 992 ? 20 : 10),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'HEIGHT',
                      style: labelTextStyle.copyWith(
                        fontSize: constraint.maxWidth < 992 ? 20 : 12,
                      ),
                    ),
                  ),
                  SizedBox(height: constraint.maxWidth < 992 ? 12 : 5),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${height.toInt()}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: constraint.maxWidth < 992 ? 50 : 40,
                          ),
                        ),
                        Text(
                          'cm',
                          style: TextStyle(color: secondColor),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Slider(
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
                      sideSpace: constraint.maxWidth < 992 ? 2 : 7,
                      centerSpace: constraint.maxWidth < 992 ? 20 : 5,
                      sizelabel: constraint.maxWidth < 992 ? 20 : 12,
                      sizeMeasure: constraint.maxWidth < 992 ? 40 : 30,
                      label: 'WEIGHT',
                      measureLabel: 'kg',
                      measure: weight,
                      button1: AritMathicButton(
                        bgColor: primaryColorLighter,
                        splashColor: primaryColorDarker,
                        iconColor: secondColor,
                        radius: constraint.maxWidth < 992 ? 50 : 30,
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
                        radius: constraint.maxWidth < 992 ? 50 : 30,
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
                      sideSpace: constraint.maxWidth < 992 ? 2 : 7,
                      centerSpace: constraint.maxWidth < 992 ? 20 : 5,
                      sizelabel: constraint.maxWidth < 992 ? 20 : 12,
                      sizeMeasure: constraint.maxWidth < 992
                          ? 40
                          : constraint.maxWidth < 400
                              ? 10
                              : 30,
                      label: 'AGE',
                      measureLabel: 'y.o',
                      button1: AritMathicButton(
                        bgColor: primaryColorLighter,
                        splashColor: primaryColorDarker,
                        iconColor: secondColor,
                        radius: constraint.maxWidth < 992 ? 50 : 30,
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
                        radius: constraint.maxWidth < 992 ? 50 : 30,
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
                            vertical: MediaQuery.of(context).size.height * 0.08,
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
                  height: constraint.maxWidth < 992 ? 60 : 45,
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
    );
  }
}
