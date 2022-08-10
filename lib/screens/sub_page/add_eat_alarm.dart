import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bmi_app/constants/constants.dart';
import 'package:bmi_app/data/data.dart';
import 'package:bmi_app/data/theme_data.dart';
import 'package:bmi_app/models/alarm_model.dart';

class AddEatAlarmScreen extends StatelessWidget {
  const AddEatAlarmScreen({
    Key? key,
    required this.title,
    this.paddingTop,
  }) : super(key: key);

  final String title;
  final double? paddingTop;

  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).padding.top;
    DateTime? alarmTime;
    late String alarmTimeString;
    bool isRepeatSelected = false;
    // var args = ModalRoute.of(context)!.settings.arguments;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: alarms.map<Widget>((alarm) {
                var gradientColor = GradientTemplate
                    .gradientTemplate[alarm.gradientColorIndex ?? 0].colors;

                return AlarmWidget(gradientColor: gradientColor, alarm: alarm);
              }).followedBy([
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: DottedBorder(
                    strokeWidth: 3,
                    dashPattern: const [5, 4],
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(24),
                    color: Colors.white.withOpacity(0.5),
                    child: Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.indigo.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          alarmTimeString =
                              DateFormat('HH:mm').format(DateTime.now());
                          await _buildAddAlarmPanel(context, alarmTime,
                              alarmTimeString, isRepeatSelected);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.alarm_add,
                              size: 50,
                              color: Colors.white.withOpacity(0.5),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Add Alarm',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]).toList(),
            ),
          )
        ],
      ),
    );
  }

  _buildAddAlarmPanel(BuildContext context, DateTime? alarmTime,
      String alarmTimeString, bool isRepeatSelected) async {
    showModalBottomSheet(
      backgroundColor: primaryColorDarker,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () async {
                      var selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (selectedTime != null) {
                        final now = DateTime.now();
                        var selectedDateTime = DateTime(now.year, now.month,
                            now.day, selectedTime.hour, selectedTime.minute);
                        alarmTime = selectedDateTime;
                        setModalState(() {
                          alarmTimeString =
                              DateFormat('HH:mm').format(selectedDateTime);
                        });
                      }
                    },
                    child: Text(
                      alarmTimeString,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Repeat',
                      style: clockTextStyle,
                    ),
                    trailing: Switch(
                      activeColor: Colors.red.shade900,
                      onChanged: (value) {
                        setModalState(() {
                          isRepeatSelected = value;
                        });
                      },
                      value: isRepeatSelected,
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Sound',
                      style: clockTextStyle,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                  ),
                  ListTile(
                    title: Text(
                      'Title',
                      style: clockTextStyle,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                  ),
                  FloatingActionButton.extended(
                    onPressed: () {
                      // onSaveAlarm(isRepeatSelected);
                    },
                    icon: const Icon(Icons.alarm),
                    label: const Text('Save'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class AlarmWidget extends StatelessWidget {
  const AlarmWidget({
    Key? key,
    required this.alarm,
    required this.gradientColor,
  }) : super(key: key);

  final Alarm alarm;
  final List<Color> gradientColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 5,
            color: gradientColor[0],
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.label,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    alarm.title ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Switch(
                value: true,
                activeColor: Colors.white,
                onChanged: (value) {},
              ),
            ],
          ),
          const Text(
            'Mon-Fri',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${alarm.alarmDateTime?.hour.toString()} : ${alarm.alarmDateTime?.minute.toString()}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
