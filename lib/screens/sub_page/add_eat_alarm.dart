import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:bmi_app/constants/constants.dart';
import 'package:bmi_app/data/data.dart';

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
    // var args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
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
                children: alarms.map<Widget>((alarm) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 5,
                          color: alarm.gradients![0].withOpacity(0.2),
                          offset: const Offset(0, 0),
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: alarm.gradients!,
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
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
                                  alarm.description!,
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
                          children: const [
                            Text(
                              '07:00 AM',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 24,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }).followedBy([
                  DottedBorder(
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
                        onPressed: () {},
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
                ]).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
