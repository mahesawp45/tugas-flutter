import 'package:bmi_app/R/r.dart';
import 'package:bmi_app/database/alarm_hive.dart';
import 'package:bmi_app/main.dart';
import 'package:bmi_app/widgets/mini/title_widget.dart';
import 'package:bmi_app/widgets/object/alarm_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:bmi_app/data/theme_data.dart';

class AddEatAlarmScreen extends StatefulWidget {
  const AddEatAlarmScreen({
    Key? key,
    required this.title,
    this.paddingTop,
  }) : super(key: key);

  final String title;
  final double? paddingTop;

  @override
  State<AddEatAlarmScreen> createState() => _AddEatAlarmScreenState();
}

class _AddEatAlarmScreenState extends State<AddEatAlarmScreen> {
  List<AlarmHive> alarms = [];

  Box? myalarm = Hive.box(alarmBox);

  @override
  void initState() {
    super.initState();
    _refreshAlarms();
  }

  // Get semua alarm dari DB
  void _refreshAlarms() {
    final data = myalarm?.keys.map((key) {
      final value = myalarm?.get(key);

      return AlarmHive()
        ..title = value.title
        ..alarmDateTime = value.alarmDateTime
        ..isActive = value.isActive
        ..isRepeat = value.isRepeat
        ..gradientColorIndex = value.gradientColorIndex;
    }).toList();

    setState(() {
      alarms = data?.reversed.toList() ?? [];
    });
  }

  // CREATE alarm
  _createAlarm(AlarmHive newAlarm) async {
    await myalarm!.add(newAlarm);

    _refreshAlarms();
  }

  // SHOW 1 alarm
  Map<String, dynamic> _readAlarm(key) {
    final alarm = myalarm?.get(key);
    return alarm;
  }

  // UPDATE alarm
  _updateAlarm(itemKey, AlarmHive item) async {
    await myalarm?.put(itemKey, item);
    _refreshAlarms();
  }

  // DELETE alarm
  Future _deleteAlarm(AlarmHive e) async {
    myalarm?.keys.map((key) {
      var a = myalarm?.get(key);
      if (a.title == e.title) a.delete();
    }).toList();

    // await myalarm?.delete(e);
    _refreshAlarms();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          'One Alarm has been deleted',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).padding.top;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: paddingTop),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: TitleWidget(
              title: widget.title.toString(),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              shrinkWrap: true,
              children: alarms.map<Widget>((e) {
                var gradientColor = GradientTemplate
                    .gradientTemplate[e.gradientColorIndex ?? 0].colors;

                TextEditingController titleC = TextEditingController();

                titleC.text = e.title!;

                if (alarms.isEmpty) {
                  return const Text(
                    'NO ALARM',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  );
                } else {
                  return GestureDetector(
                    child: AlarmWidget(gradientColor: gradientColor, data: e),
                    onTap: () {
                      _showEditAlarmDialog(
                          e: e, gradientColor: gradientColor, titleC: titleC);
                    },
                  );
                }
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
                          await _buildAddAlarmPanel(context);
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

  _showEditAlarmDialog(
      {required AlarmHive e,
      required TextEditingController titleC,
      required List<Color> gradientColor}) {
    String timeVal =
        "${e.alarmDateTime?.hour.toString() ?? ''} : ${e.alarmDateTime?.minute.toString() ?? ''} ${(e.alarmDateTime?.hour ?? 0) < 12 ? 'AM' : 'PM'}";
    int colorVal = e.gradientColorIndex!;
    bool isRepeat = e.isRepeat!;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: Colors.transparent,
              content: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(colors: gradientColor),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      color: gradientColor[0],
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  children: [
                    _buildTextEditingTitle(titleC),

                    // TIME
                    ListTile(
                        title: Text(
                          'Time ',
                          style: R.appTextStyle.clockTextStyle,
                        ),
                        trailing: Text(
                          timeVal,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        onTap: () async {
                          var selectedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(
                                e.alarmDateTime ?? DateTime.now()),
                          );

                          if (selectedTime != null) {
                            final now = DateTime.now();
                            var selectedDateTime = DateTime(
                                now.year,
                                now.month,
                                now.day,
                                selectedTime.hour,
                                selectedTime.minute);
                            setDialogState(() {
                              timeVal =
                                  "${DateFormat('HH:mm').format(selectedDateTime)} ${selectedDateTime.hour < 12 ? 'AM' : 'PM'}";
                            });
                          }
                        }),

                    // COLOR
                    ListTile(
                      title: Text(
                        'Color',
                        style: R.appTextStyle.clockTextStyle,
                      ),
                      trailing: ColorButton(
                        colorVal: colorVal,
                      ),
                      onTap: () {
                        List<ListTile> colorList = List.generate(
                            GradientTemplate.gradientTemplate.length, (index) {
                          return ListTile(
                            onTap: () {
                              setDialogState(() {
                                colorVal = index;
                                gradientColor = GradientTemplate
                                    .gradientTemplate[colorVal].colors;
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

                    ListTile(
                      title: Text(
                        'Repeat',
                        style: R.appTextStyle.clockTextStyle,
                      ),
                      trailing: Switch(
                        value: isRepeat,
                        trackColor: MaterialStateProperty.all(
                            Colors.white.withOpacity(0.5)),
                        thumbColor: MaterialStateProperty.all(Colors.white),
                        onChanged: (value) {
                          setDialogState(() {
                            isRepeat = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 50),
                                        padding: const EdgeInsets.only(
                                          top: 70,
                                          bottom: 20,
                                          left: 20,
                                          right: 20,
                                        ),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        width:
                                            MediaQuery.of(context).size.height *
                                                0.9,
                                        decoration: BoxDecoration(
                                          color:
                                              R.appColors.primaryColorLighter,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Are you sure delete alarm ${e.title}?',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                TextButton(
                                                  onPressed: () async {
                                                    await _deleteAlarm(e);
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Yeah, Sure!',
                                                    style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 20),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.white,
                                                  ),
                                                  child: Text(
                                                    'Nope!',
                                                    style: TextStyle(
                                                        color: R.appColors
                                                            .primaryColorDarker),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        top: -10,
                                        child: Icon(Icons.warning_rounded,
                                            size: 100,
                                            shadows: [
                                              Shadow(
                                                color: Colors.red.shade800,
                                                blurRadius: 50,
                                                offset: const Offset(0, 0),
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check_circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Container _buildTextEditingTitle(TextEditingController titleC) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        controller: titleC,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusColor: Colors.white,
        ),
      ),
    );
  }

  _buildAddAlarmPanel(BuildContext context) async {
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
                              _buildCancelButton(context),
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
                        ..alarmDateTime = alarmTime
                        ..isActive = true
                        ..isRepeat = isRepeatSelected
                        ..gradientColorIndex = colorVal
                        ..key = DateTime.now().toString();

                      if (titleVal == 'Title') {
                        showTitleNullDialog();
                      } else {
                        _createAlarm(data);

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

  void showTitleNullDialog() {
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

  TextButton _buildCancelButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Cancel',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class ColorButton extends StatelessWidget {
  const ColorButton({
    Key? key,
    required this.colorVal,
  }) : super(key: key);

  final int colorVal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 5,
            offset: const Offset(0, 0),
            color: GradientTemplate.gradientTemplate[colorVal].colors.first,
          ),
        ],
        gradient: LinearGradient(
          colors: GradientTemplate.gradientTemplate[colorVal].colors,
        ),
      ),
    );
  }
}
