import 'package:bmi_app/constants/constants.dart';
import 'package:bmi_app/helpers/bmi_calculator.dart';
import 'package:bmi_app/widgets/bmi_card_widget.dart';
import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
  const BMIResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widthTombol = MediaQuery.of(context).size.width;
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    double bmi = args['bmi'];

    final BMICalculator bmiCalculator = BMICalculator.fromBMIValue(bmi: bmi);
    bmiCalculator.determineBMICategory();
    bmiCalculator.getHealthRiskDescription();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BMI CALCULATOR'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Your Result',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          BMICardWidget(
            color: primaryColorLighter,
            child: SizedBox(
              width: widthTombol,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    Text(
                      bmiCalculator.bmiCategory ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: bmiCalculator.resultColor,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      bmi.toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Text(
                      bmiCalculator.bmiDescription ?? '',
                      textAlign: TextAlign.center,
                      style: labelTextStyle.copyWith(fontSize: 20),
                    ),
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.red.shade900,
              height: 60,
              width: widthTombol,
              child: Center(
                child: Text(
                  'RE-CALCULATE',
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
