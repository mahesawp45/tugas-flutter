import 'package:bmi_app/R/r.dart';
import 'package:bmi_app/providers/bmi_calculator_provider.dart';
import 'package:bmi_app/widgets/card/bmi_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BMIResultScreen extends StatelessWidget {
  const BMIResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BMICalculatorProvider bmiCalculatorProvider =
        Provider.of<BMICalculatorProvider>(context, listen: false);
    bmiCalculatorProvider.determineBMICategory();
    bmiCalculatorProvider.getHealthRiskDescription();
    double? bmi = bmiCalculatorProvider.bmi;
    final widthTombol = MediaQuery.of(context).size.width;

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
            color: R.appColors.primaryColorLighter,
            child: SizedBox(
              width: widthTombol,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 1),
                    Consumer<BMICalculatorProvider>(
                        builder: (context, bmiCalcuProvider, child) {
                      return Text(
                        bmiCalcuProvider.bmiCategory ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: bmiCalcuProvider.resultColor,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }),
                    const Spacer(flex: 1),
                    Text(
                      (bmi ?? 0).toStringAsFixed(1),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(flex: 1),
                    Consumer<BMICalculatorProvider>(
                        builder: (context, bmiCalcuProvider, child) {
                      return Text(
                        bmiCalculatorProvider.bmiDescription ?? '',
                        textAlign: TextAlign.center,
                        style: R.appTextStyle.labelTextStyle
                            .copyWith(fontSize: 20),
                      );
                    }),
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
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red.shade900,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.red.shade800,
                    offset: const Offset(0, 2),
                    spreadRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              height: 60,
              width: widthTombol,
              child: Center(
                child: Text(
                  'RE-CALCULATE',
                  style: R.appTextStyle.calculateTextStyle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
