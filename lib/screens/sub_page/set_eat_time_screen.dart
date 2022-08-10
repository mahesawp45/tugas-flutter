import 'dart:async';

import 'package:bmi_app/data/data.dart';
import 'package:bmi_app/data/theme_data.dart';
import 'package:bmi_app/screens/sub_page/add_eat_alarm.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bmi_app/constants/constants.dart';
import 'package:bmi_app/screens/sub_page/clock_view.dart';

class SetEatTimeScreen extends StatefulWidget {
  final String title;
  final BoxConstraints constraints;

  const SetEatTimeScreen({
    Key? key,
    required this.title,
    required this.constraints,
  }) : super(key: key);

  @override
  State<SetEatTimeScreen> createState() => _SetEatTimeScreenState();
}

class _SetEatTimeScreenState extends State<SetEatTimeScreen> {
  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    }).cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDay = DateFormat('EEEE, d MMMM').format(now);
    var timeZone = now.timeZoneOffset.toString().split('.').first;
    var offSetSign = '';

    if (!timeZone.startsWith('-')) {
      offSetSign = '+';
    }

    var paddingTop = MediaQuery.of(context).padding.top;
    // var args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: widget.constraints.maxWidth < 922 ? 0 : 20),
        child: widget.constraints.maxWidth < 992
            ? _buildMobile(
                paddingTop, formattedTime, formattedDay, offSetSign, timeZone)
            : _buildDesktop(
                paddingTop, formattedTime, formattedDay, offSetSign, timeZone),
      ),
    );
  }

  Row _buildDesktop(double paddingTop, String formattedTime,
      String formattedDay, String offSetSign, String timeZone) {
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
                  title: widget.title.toString(),
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            formattedTime,
                            style: clockTextStyle.copyWith(fontSize: 64),
                          ),
                          Text(
                            formattedDay,
                            style: clockTextStyle,
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Text(
                        'Timezone',
                        style: clockTextStyle,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.language,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'UTC $offSetSign $timeZone',
                            style: clockTextStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
                      Text("Your Upcoming Alarm, let's prepare!",
                          style: clockTextStyle.copyWith(fontSize: 15)),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: AlarmWidget(
                          alarm: alarms[0],
                          gradientColor: gradientColor,
                        ),
                      ),
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
        const Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.only(right: 20, top: 50),
            child: Align(
              alignment: Alignment.topCenter,
              child: ClockView(sizeClock: 500),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildMobile(double paddingTop, String formattedTime,
      String formattedDay, String offSetSign, String timeZone) {
    var gradientColor = GradientTemplate
        .gradientTemplate[alarms[0].gradientColorIndex ?? 0].colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: paddingTop),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child: TitleWidget(
            title: widget.title.toString(),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(left: 20),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formattedTime,
                    style: clockTextStyle.copyWith(fontSize: 64),
                  ),
                  Text(
                    formattedDay,
                    style: clockTextStyle,
                  ),
                ],
              ),
              const Spacer(),
              const Padding(
                padding: EdgeInsets.only(right: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: ClockView(sizeClock: 250),
                ),
              ),
              const Spacer(),
              Text(
                'Timezone',
                style: clockTextStyle,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'UTC $offSetSign $timeZone',
                    style: clockTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Text("Your Upcoming Alarm, let's prepare!",
                  style: clockTextStyle.copyWith(fontSize: 15)),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: AlarmWidget(
                  alarm: alarms[0],
                  gradientColor: gradientColor,
                ),
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
