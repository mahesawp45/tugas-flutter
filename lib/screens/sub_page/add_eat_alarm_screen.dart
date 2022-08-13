import 'package:bmi_app/R/r.dart';
import 'package:bmi_app/widgets/mini/title_widget.dart';
import 'package:bmi_app/widgets/object/alarm_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bmi_app/data/data.dart';
import 'package:bmi_app/data/theme_data.dart';

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
                    strokeWidth: 2,
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
      backgroundColor: R.appColors.primaryColorLighter,
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
                      style: R.appTextStyle.clockTextStyle,
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
                      style: R.appTextStyle.clockTextStyle,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                  ),
                  ListTile(
                    title: Text(
                      'Title',
                      style: R.appTextStyle.clockTextStyle,
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
