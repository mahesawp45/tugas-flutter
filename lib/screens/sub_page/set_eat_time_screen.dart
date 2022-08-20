import 'package:bmi_app/R/r.dart';
import 'package:bmi_app/data/data.dart';
import 'package:bmi_app/data/theme_data.dart';
import 'package:bmi_app/providers/clock_provider.dart';
import 'package:bmi_app/widgets/mini/title_widget.dart';
import 'package:flutter/material.dart';

import 'package:bmi_app/screens/sub_page/clock_view.dart';
import 'package:provider/provider.dart';

class SetEatTimeScreen extends StatelessWidget {
  final String title;
  final BoxConstraints constraints;

  const SetEatTimeScreen({
    Key? key,
    required this.title,
    required this.constraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ClockProvider clockProvider =
        Provider.of<ClockProvider>(context, listen: false);
    var timeZone = clockProvider.timeZone;
    var offSetSign = '';

    if (!(timeZone ?? '').startsWith('-')) {
      offSetSign = '+';
    }

    var paddingTop = MediaQuery.of(context).padding.top;
    // var args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: constraints.maxWidth < 922 ? 0 : 20),
        child: constraints.maxWidth < 992
            ? _buildMobile(paddingTop, offSetSign, timeZone ?? '')
            : _buildDesktop(paddingTop, offSetSign, timeZone ?? ''),
      ),
    );
  }

  Row _buildDesktop(double paddingTop, String offSetSign, String timeZone) {
    var gradientColor = GradientTemplate
        .gradientTemplate[alarms[0].gradientColorIndex ?? 0].colors;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: paddingTop),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TitleWidget(
                  title: title.toString(),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListView(
                    children: [
                      Consumer<ClockProvider>(
                          builder: (context, clockProvider, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              clockProvider.formattedTime ?? '',
                              style: R.appTextStyle.clockTextStyle
                                  .copyWith(fontSize: 64),
                            ),
                            Text(
                              clockProvider.formattedDay ?? '',
                              style: R.appTextStyle.clockTextStyle,
                            ),
                          ],
                        );
                      }),
                      const SizedBox(height: 50),
                      Text(
                        'Timezone',
                        style: R.appTextStyle.clockTextStyle,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.language,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Consumer<ClockProvider>(
                              builder: (context, clockProvider, child) {
                            return Text(
                              'UTC $offSetSign ${clockProvider.timeZone}',
                              style: R.appTextStyle.clockTextStyle
                                  .copyWith(fontSize: 14),
                            );
                          }),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Text("Your Upcoming Alarm, let's prepare!",
                          style: R.appTextStyle.clockTextStyle
                              .copyWith(fontSize: 15)),
                      const SizedBox(height: 20),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 20),
                      //   child: AlarmWidget(
                      //     alarm: alarms[0],
                      //     gradientColor: gradientColor,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              // const Spacer(
              //   flex: 2,
              // ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.only(right: 20, top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: Consumer<ClockProvider>(
                  builder: (context, clockProvider, child) {
                return const ClockView(sizeClock: 500);
              }),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildMobile(double paddingTop, String offSetSign, String timeZone) {
    var gradientColor = GradientTemplate
        .gradientTemplate[alarms[0].gradientColorIndex ?? 0].colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: paddingTop),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: TitleWidget(
            title: title.toString(),
          ),
        ),
        const SizedBox(height: 30),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(left: 20),
            children: [
              Consumer<ClockProvider>(builder: (context, clockProvider, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clockProvider.formattedTime ?? '',
                      style:
                          R.appTextStyle.clockTextStyle.copyWith(fontSize: 64),
                    ),
                    Text(
                      clockProvider.formattedDay ?? '',
                      style:
                          R.appTextStyle.clockTextStyle.copyWith(fontSize: 18),
                    ),
                  ],
                );
              }),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Consumer<ClockProvider>(
                      builder: (context, clockProvider, child) {
                    return const ClockView(sizeClock: 250);
                  }),
                ),
              ),
              Text(
                'Timezone',
                style: R.appTextStyle.clockTextStyle,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Consumer<ClockProvider>(
                      builder: (context, clockProvider, child) {
                    return Text(
                      'UTC $offSetSign ${clockProvider.timeZone ?? ""}',
                      style:
                          R.appTextStyle.clockTextStyle.copyWith(fontSize: 14),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 50),
              Text("Your Upcoming Alarm, let's prepare!",
                  style: R.appTextStyle.clockTextStyle.copyWith(fontSize: 15)),
              const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.only(right: 20),
              //   child: AlarmWidget(
              //     alarm: alarms[0],
              //     gradientColor: gradientColor,
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
