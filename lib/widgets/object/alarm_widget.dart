import 'package:bmi_app/models/alarm_model.dart';
import 'package:flutter/material.dart';

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
