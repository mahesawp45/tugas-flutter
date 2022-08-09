import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bmi_app/constants/constants.dart';
import 'package:bmi_app/screens/sub_page/clock_view.dart';

class SetEatTimeScreen extends StatefulWidget {
  final String title;

  const SetEatTimeScreen({
    Key? key,
    required this.title,
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
        padding: const EdgeInsets.only(left: 20),
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
            const Spacer(
              flex: 8,
            ),
          ],
        ),
      ),
    );
  }
}
