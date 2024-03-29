import 'package:bmi_app/R/r.dart';
import 'package:bmi_app/widgets/mini/title_widget.dart';
import 'package:flutter/material.dart';

class ChallangeScreen extends StatelessWidget {
  const ChallangeScreen({
    Key? key,
    required this.title,
    this.paddingTop,
  }) : super(key: key);

  final String title;

  final double? paddingTop;

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: paddingTop),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TitleWidget(
                  title: title,
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning_rounded,
                          size: 150,
                          color: R.appColors.secondColor.withOpacity(0.4),
                        ),
                        const Text(
                          'Page Not Found, sorry..',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
