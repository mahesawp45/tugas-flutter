import 'package:bmi_app/R/r.dart';
import 'package:bmi_app/data/theme_data.dart';
import 'package:bmi_app/database/alarm_hive.dart';
import 'package:bmi_app/providers/alarm_provider.dart';
import 'package:bmi_app/providers/clock_provider.dart';
import 'package:bmi_app/screens/sub_page/add_eat_alarm_screen.dart';
import 'package:bmi_app/widgets/mini/title_widget.dart';
import 'package:bmi_app/widgets/object/alarm_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:bmi_app/screens/sub_page/clock_view.dart';
import 'package:intl/intl.dart';
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
    AlarmProvider alarmProvider =
        Provider.of<AlarmProvider>(context, listen: false);

    alarmProvider.refreshAlarms();

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
                      Consumer<AlarmProvider>(
                        builder: (context, alarmProvider, child) {
                          AlarmHive? alarm;
                          List<Color>? gradientColor;

                          if (alarmProvider.alarms.isNotEmpty) {
                            alarm = alarmProvider.alarms[0];
                            gradientColor = GradientTemplate
                                .gradientTemplate[alarm.gradientColorIndex ?? 0]
                                .colors;
                          }

                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: alarm != null
                                ? Column(
                                    children: [
                                      const SizedBox(height: 50),
                                      Text(
                                          "Your Upcoming Alarm, let's prepare!",
                                          style: R.appTextStyle.clockTextStyle
                                              .copyWith(fontSize: 15)),
                                      const SizedBox(height: 20),
                                      AlarmWidget(
                                        data: alarmProvider.alarms[0],
                                        gradientColor: gradientColor ?? [],
                                        isActiveSwitch: Switch(
                                          value: alarm.isActive ?? false,
                                          activeColor: Colors.white,
                                          onChanged: (value) {
                                            if (alarm != null) {
                                              var data = alarm
                                                ..title = alarm.title
                                                ..alarmDateTime =
                                                    alarm.alarmDateTime
                                                ..isActive = value
                                                ..isRepeat = value
                                                ..gradientColorIndex =
                                                    alarm.gradientColorIndex
                                                ..stringID = alarm.stringID;
                                              alarmProvider.updateAlarm(data);
                                            }
                                          },
                                        ),
                                        isActive: alarm.isActive,
                                      ),
                                    ],
                                  )
                                : DottedBorder(
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
                                          await _buildAddAlarmPanel(
                                              context, alarmProvider);
                                        },
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.alarm_add,
                                              size: 50,
                                              color:
                                                  Colors.white.withOpacity(0.5),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "No Alarm yet, Let's make!",
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
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
              Consumer<AlarmProvider>(
                builder: (context, alarmProvider, child) {
                  AlarmHive? alarm;
                  List<Color>? gradientColor;

                  if (alarmProvider.alarms.isNotEmpty) {
                    alarm = alarmProvider.alarms.firstWhere(
                      (element) =>
                          element.alarmDateTime!.hour >= DateTime.now().hour ||
                          element.alarmDateTime!.minute > DateTime.now().minute,
                    );

                    gradientColor = GradientTemplate
                        .gradientTemplate[alarm.gradientColorIndex ?? 0].colors;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: alarm != null
                        ? Column(
                            children: [
                              Text("Your Upcoming Alarm, let's prepare!",
                                  style: R.appTextStyle.clockTextStyle
                                      .copyWith(fontSize: 12)),
                              const SizedBox(height: 20),
                              AlarmWidget(
                                data: alarm,
                                gradientColor: gradientColor ?? [],
                                isActiveSwitch: Switch(
                                  value: alarm.isActive ?? false,
                                  activeColor: Colors.white,
                                  onChanged: (value) {
                                    if (alarm != null) {
                                      var data = alarm
                                        ..title = alarm.title
                                        ..alarmDateTime = alarm.alarmDateTime
                                        ..isActive = value
                                        ..isRepeat = value
                                        ..gradientColorIndex =
                                            alarm.gradientColorIndex
                                        ..stringID = alarm.stringID;
                                      alarmProvider.updateAlarm(data);
                                    }
                                  },
                                ),
                                isActive: alarm.isActive,
                              ),
                            ],
                          )
                        : DottedBorder(
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
                                  await _buildAddAlarmPanel(
                                      context, alarmProvider);
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
                                      "No Alarm yet, Let's make!",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildAddAlarmPanel(BuildContext context, AlarmProvider alarmProvider) async {
    //
    DateTime? alarmTime;
    String alarmTimeString =
        "${DateFormat('HH:mm').format(DateTime.now())} ${DateTime.now().hour < 12 ? 'AM' : 'PM'}";

    bool isRepeatSelected = false;
    String titleVal = 'Title';
    TextEditingController titleC = TextEditingController();
    int colorVal = 0;

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
                  // WAKTU
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
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.red.shade900,
                        shadows: const [
                          Shadow(
                            color: Colors.red,
                            blurRadius: 20,
                            offset: Offset(0, 0),
                          ),
                        ],
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

                  // TITLE
                  ListTile(
                    title: Text(
                      titleVal,
                      style: R.appTextStyle.clockTextStyle,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: R.appColors.primaryColorLighter,
                            title: const Text(
                              'Add Title',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            content: _buildTitleAlarmInput(titleC),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary: Colors.white,
                                ),
                                onPressed: () {
                                  setModalState(() {
                                    titleVal = titleC.text;
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      color: R.appColors.primaryColor),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          );
                        },
                      );
                    },
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                  ),

                  // COLOR
                  ListTile(
                    title: Text(
                      'Color',
                      style: R.appTextStyle.clockTextStyle,
                    ),
                    trailing: ColorButton(colorVal: colorVal),
                    onTap: () {
                      List<ListTile> colorList = List.generate(
                          GradientTemplate.gradientTemplate.length, (index) {
                        return ListTile(
                          onTap: () {
                            setModalState(() {
                              colorVal = index;
                            });
                            Navigator.pop(context);
                          },
                          leading: _buildColorSelector(index),
                          trailing: Text(
                            GradientTemplate.colorName[index],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList();

                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            scrollable: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: R.appColors.primaryColorLighter,
                            title: const Text(
                              'Choose the Color',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            content: Column(
                              children: colorList,
                            ),
                          );
                        },
                      );
                    },
                  ),

                  FloatingActionButton.extended(
                    onPressed: () async {
                      var data = AlarmHive()
                        ..title = titleVal
                        ..alarmDateTime = alarmTime ?? DateTime.now()
                        ..isActive = true
                        ..isRepeat = isRepeatSelected
                        ..gradientColorIndex = colorVal
                        ..stringID = DateTime.now().toString();

                      if (titleVal == 'Title') {
                        showTitleNullDialog(context);
                      } else {
                        alarmProvider.createAlarm(data);

                        Navigator.pop(context);
                      }
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

  void showTitleNullDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Oops Sorry',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          content: const Text(
            "The title should be given!, let's try again",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: R.appColors.primaryColorLighter,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Ok!',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Container _buildColorSelector(int index) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 0),
            color: GradientTemplate.gradientTemplate[index].colors.first,
          ),
        ],
        gradient: LinearGradient(
          colors: GradientTemplate.gradientTemplate[index].colors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }

  Container _buildTitleAlarmInput(TextEditingController titleC) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: titleC,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          focusColor: Colors.white,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
