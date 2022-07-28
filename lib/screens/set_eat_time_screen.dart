import 'package:bmi_app/screens/clock_view.dart';
import 'package:bmi_app/widgets/menu_side_bar_wigdet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bmi_app/constants/constants.dart';

class SetEatTimeScreen extends StatefulWidget {
  const SetEatTimeScreen({Key? key}) : super(key: key);

  @override
  State<SetEatTimeScreen> createState() => _SetEatTimeScreenState();
}

class _SetEatTimeScreenState extends State<SetEatTimeScreen> {
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
    var spacerMenu = MediaQuery.of(context).size.height * 0.15;
    var args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: MenuSideBarWidget(
                paddingTop: paddingTop, spacerMenu: spacerMenu),
          ),
          VerticalDivider(color: secondColor, width: 1),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: paddingTop),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TitleWidget(
                      title: args.toString(),
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
          ),
        ],
      ),
    );
  }
}