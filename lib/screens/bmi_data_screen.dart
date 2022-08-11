import 'package:bmi_app/R/r.dart';

import 'package:bmi_app/providers/bmi_calculator_provider.dart';
import 'package:bmi_app/providers/bmi_provider.dart';
import 'package:bmi_app/providers/clock_provider.dart';
import 'package:bmi_app/screens/sub_page/add_eat_alarm.dart';
import 'package:bmi_app/screens/sub_page/challenge_screen.dart';
import 'package:bmi_app/screens/sub_page/set_eat_time_screen.dart';
import 'package:bmi_app/widgets/button/main_menu_button.dart';
import 'package:bmi_app/widgets/button/menu_button_widget.dart';
import 'package:bmi_app/widgets/card/bmi_card_widget.dart';
import 'package:bmi_app/widgets/card/gender_widget.dart';
import 'package:bmi_app/widgets/card/measurement_widget.dart';
import 'package:bmi_app/widgets/mini/title_widget.dart';
import 'package:flutter/material.dart';

import 'package:bmi_app/routes/app_pages.dart';
import 'package:bmi_app/widgets/button/aritmathic_button_widget.dart';
import 'package:provider/provider.dart';

class BMIDataScreen extends StatefulWidget {
  const BMIDataScreen({Key? key}) : super(key: key);

  @override
  State<BMIDataScreen> createState() => _BMIDataScreenState();
}

class _BMIDataScreenState extends State<BMIDataScreen> {
  BMIProvider? bmiProvider;
  int? height;
  int? weight;
  int? age;

  final PageController _pageController = PageController();
  String? title;
  int index = 0;
  @override
  void initState() {
    bmiProvider = Provider.of<BMIProvider>(context, listen: false);
    bmiProvider?.dataBMIInit();
    height = bmiProvider?.getHeightBMI;
    weight = bmiProvider?.getWeightBMI;
    age = bmiProvider?.getAgeBMI;
    super.initState();
  }

  @override
  void dispose() {
    ClockProvider().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthTombol = MediaQuery.of(context).size.width;
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
            VerticalDivider(color: R.appColors.secondColor, width: 2),
            Expanded(
              flex: constraint.maxWidth < 992 ? 4 : 8,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: _pageController,
                children: [
                  _buildHomeScreen(
                    paddingTop,
                    // bmiCalculator,
                    constraint,
                    context,
                    widthTombol,
                  ),
                  const ChallangeScreen(
                    title: 'Challange',
                  ),
                  SetEatTimeScreen(
                    constraints: constraint,
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
          // SizedBox(height: spacerMenu),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: constraint.maxWidth < 992 ? 10 : 35,
                  vertical: 20),
              child: ListView(
                children: [
                  MenuButton(
                    constraints: constraint,
                    bgColor: title == 'Challange'
                        ? MaterialStateProperty.all(Colors.red.shade900)
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
                    constraints: constraint,
                    bgColor: title == 'Eat Time'
                        ? MaterialStateProperty.all(Colors.red.shade900)
                        : MaterialStateProperty.all(Colors.transparent),
                    icon: Icons.food_bank_outlined,
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
                    constraints: constraint,
                    bgColor: title == 'Set Alarm'
                        ? MaterialStateProperty.all(Colors.red.shade900)
                        : MaterialStateProperty.all(Colors.transparent),
                    icon: Icons.watch_later_outlined,
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
                    constraints: constraint,
                    icon: Icons.star,
                    title: '',
                    onTap: () {},
                  ),
                  MenuButton(
                    constraints: constraint,
                    icon: Icons.share,
                    title: '',
                    onTap: () {},
                  ),
                  MenuButton(
                    constraints: constraint,
                    icon: Icons.settings,
                    title: '',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildHomeScreen(double paddingTop, BoxConstraints constraint,
      BuildContext context, double widthTombol) {
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
                  Consumer<BMIProvider>(builder: (context, bmiProvider, child) {
                    return BMICardWidget(
                      child: GenderWidget(
                        iconSize: constraint.maxWidth < 992 ? 80 : 90,
                        borderColor: bmiProvider.gender == "male"
                            ? Colors.red
                            : Colors.transparent,
                        onTap: () {
                          bmiProvider.gender = 'male';
                          bmiProvider.setIsMale(true);
                          bmiProvider.setIsFemale(false);
                        },
                        textGender: 'Male',
                        iconGender: Icons.male,
                      ),
                    );
                  }),
                  Consumer<BMIProvider>(builder: (context, bmiProvider, child) {
                    return BMICardWidget(
                      child: GenderWidget(
                        iconSize: constraint.maxWidth < 992 ? 80 : 90,
                        borderColor: bmiProvider.gender == 'female'
                            ? Colors.red
                            : Colors.transparent,
                        onTap: () {
                          bmiProvider.gender = 'female';
                          bmiProvider.setIsFemale(true);
                          bmiProvider.setIsMale(false);
                        },
                        textGender: 'Female',
                        iconGender: Icons.female,
                      ),
                    );
                  }),
                ],
              ),
            ),
            Consumer<BMIProvider>(builder: (context, bmiProvider, child) {
              return BMICardWidget(
                color: R.appColors.primaryColorDarker,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AritMathicButton(
                            aritmathicIcon: Icons.remove,
                            onTap: () {
                              if (bmiProvider.getHeightBMI > 0) {
                                bmiProvider.setDecrementHeight(height!);
                              }
                            },
                            radius: 30,
                            splashColor: R.appColors.primaryColorDarker,
                            bgColor: R.appColors.primaryColorLighter,
                            iconColor: R.appColors.secondColor,
                          ),
                          const SizedBox(width: 10),
                          AritMathicButton(
                            aritmathicIcon: Icons.add,
                            onTap: () {
                              if (bmiProvider.getHeightBMI < 250) {
                                bmiProvider.setIncrementHeight(height!);
                              }
                            },
                            radius: 30,
                            splashColor: R.appColors.primaryColorDarker,
                            bgColor: R.appColors.primaryColorLighter,
                            iconColor: R.appColors.secondColor,
                          ),
                          SizedBox(width: constraint.maxWidth < 992 ? 20 : 10),
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'HEIGHT',
                          style: R.appTextStyle.labelTextStyle.copyWith(
                            fontSize: constraint.maxWidth < 992 ? 18 : 12,
                          ),
                        ),
                      ),
                      SizedBox(height: constraint.maxWidth < 992 ? 5 : 5),
                      Expanded(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${bmiProvider.getHeightBMI}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: constraint.maxWidth < 992 ? 50 : 40,
                              ),
                            ),
                            Text(
                              'cm',
                              style: TextStyle(color: R.appColors.secondColor),
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
                          value: bmiProvider.getHeightBMI.toDouble(),
                          onChanged: (value) {
                            bmiProvider.setSlideHeight(value.toInt());
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            Expanded(
              child: Row(
                children: [
                  Consumer<BMIProvider>(builder: (context, bmiProvider, child) {
                    return BMICardWidget(
                      color: R.appColors.primaryColorDarker,
                      child: MeaSurementWidget(
                        sideSpace: constraint.maxWidth < 992 ? 12 : 10,
                        centerSpace: constraint.maxWidth < 992 ? 20 : 5,
                        sizelabel: constraint.maxWidth < 992 ? 20 : 15,
                        sizeMeasure: 40,
                        label: 'WEIGHT',
                        measureLabel: 'kg',
                        measure: bmiProvider.getWeightBMI,
                        button1: AritMathicButton(
                          bgColor: R.appColors.primaryColorLighter,
                          splashColor: R.appColors.primaryColorDarker,
                          iconColor: R.appColors.secondColor,
                          radius: constraint.maxWidth < 992 ? 50 : 60,
                          aritmathicIcon: Icons.remove,
                          onTap: () {
                            if (bmiProvider.getWeightBMI > 0) {
                              bmiProvider.setDecrementWeight(weight!);
                            }
                          },
                        ),
                        button2: AritMathicButton(
                          bgColor: R.appColors.primaryColorLighter,
                          splashColor: R.appColors.primaryColorDarker,
                          iconColor: R.appColors.secondColor,
                          radius: constraint.maxWidth < 992 ? 50 : 60,
                          aritmathicIcon: Icons.add,
                          onTap: () {
                            if (bmiProvider.getWeightBMI < 150) {
                              bmiProvider.setIncrementWeight(weight!);
                            }
                          },
                        ),
                        slider: Slider(
                          activeColor: Colors.white,
                          thumbColor: Colors.red.shade900,
                          max: 150,
                          min: 0,
                          value: bmiProvider.getWeightBMI.toDouble(),
                          onChanged: (value) {
                            bmiProvider.setSlideWeight(value.toInt());
                          },
                        ),
                      ),
                    );
                  }),
                  Consumer<BMIProvider>(builder: (context, bmiProvider, child) {
                    return BMICardWidget(
                      color: R.appColors.primaryColorDarker,
                      child: MeaSurementWidget(
                        sideSpace: constraint.maxWidth < 992 ? 12 : 10,
                        centerSpace: constraint.maxWidth < 992 ? 20 : 5,
                        sizelabel: constraint.maxWidth < 992 ? 20 : 15,
                        sizeMeasure: 40,
                        label: 'AGE',
                        measureLabel: 'y.o',
                        button1: AritMathicButton(
                          bgColor: R.appColors.primaryColorLighter,
                          splashColor: R.appColors.primaryColorDarker,
                          iconColor: R.appColors.secondColor,
                          radius: constraint.maxWidth < 992 ? 50 : 60,
                          aritmathicIcon: Icons.remove,
                          onTap: () {
                            if (bmiProvider.getAgeBMI > 0) {
                              bmiProvider.setIncrementAge(age!);
                            }
                          },
                        ),
                        button2: AritMathicButton(
                          bgColor: R.appColors.primaryColorLighter,
                          splashColor: R.appColors.primaryColorDarker,
                          iconColor: R.appColors.secondColor,
                          radius: constraint.maxWidth < 992 ? 50 : 60,
                          aritmathicIcon: Icons.add,
                          onTap: () {
                            if (bmiProvider.getAgeBMI < 150) {
                              bmiProvider.setIncrementAge(age!);
                            }
                          },
                        ),
                        measure: bmiProvider.getAgeBMI,
                        slider: Slider(
                          activeColor: Colors.white,
                          thumbColor: Colors.red.shade900,
                          max: 150,
                          min: 0,
                          value: bmiProvider.getAgeBMI.toDouble(),
                          onChanged: (value) {
                            bmiProvider.setSlideAge(value.toInt());
                          },
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            Consumer<BMIProvider>(builder: (context, bmiProvider, child) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    final BMICalculatorProvider bmiCalculatorProvider =
                        Provider.of<BMICalculatorProvider>(context,
                            listen: false);

                    if (bmiProvider.gender != null) {
                      // bmiCalculator.calculate();
                      bmiCalculatorProvider.calculate(
                          height: bmiProvider.getHeightBMI,
                          weight: bmiProvider.getWeightBMI);
                      Navigator.pushNamed(
                        context,
                        Routes.loadingScreen,
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
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            color: Colors.red.shade800,
                            offset: const Offset(0, 2),
                            spreadRadius: 2,
                          ),
                        ]),
                    height: constraint.maxWidth < 992 ? 60 : 45,
                    width: widthTombol,
                    child: Center(
                      child: Text(
                        'Calculate Your BMI',
                        style: R.appTextStyle.calculateTextStyle,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
