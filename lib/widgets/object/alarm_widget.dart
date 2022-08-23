import 'package:flutter/material.dart';

import 'package:bmi_app/database/alarm_hive.dart';
import 'package:intl/intl.dart';

class AlarmWidget extends StatelessWidget {
  const AlarmWidget({
    Key? key,
    required this.data,
    required this.gradientColor,
    required this.isActiveSwitch,
    required this.isActive,
  }) : super(key: key);

  final AlarmHive data;
  final List<Color> gradientColor;
  final Widget isActiveSwitch;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    var day = data.alarmDateTime!;

    DateFormat formatter = DateFormat('EEE');
    String repeatDay = "${formatter.format(day)}-${formatter.format(day)}";

    return Container(
      margin: const EdgeInsets.only(bottom: 32),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: isActive!
              ? gradientColor
              : [
                  Colors.grey.shade500,
                  Colors.white,
                ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 5,
            color: isActive! ? gradientColor[0] : Colors.transparent,
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
                    data.title ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              isActiveSwitch,
            ],
          ),
          Text(
            data.isRepeat! ? repeatDay : '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              data.alarmDateTime == null
                  ? const Text('data')
                  : Text(
                      "${data.alarmDateTime?.hour.toString()} : ${data.alarmDateTime!.minute > 0 ? data.alarmDateTime?.minute.toString() : '00'} ${data.alarmDateTime!.hour < 12 ? 'AM' : 'PM'}",
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
