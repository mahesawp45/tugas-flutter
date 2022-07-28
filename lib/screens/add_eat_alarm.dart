import 'package:bmi_app/constants/constants.dart';
import 'package:bmi_app/data/data.dart';
import 'package:bmi_app/widgets/menu_side_bar_wigdet.dart';
import 'package:flutter/material.dart';

class AddEatAlarmScreen extends StatelessWidget {
  const AddEatAlarmScreen({
    Key? key,
    this.paddingTop,
  }) : super(key: key);

  final double? paddingTop;

  @override
  Widget build(BuildContext context) {
    var spacerMenu = MediaQuery.of(context).size.height * 0.15;
    var paddingTop = MediaQuery.of(context).padding.top;
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
              padding: const EdgeInsets.only(left: 20, right: 20),
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
                  Expanded(
                    child: ListView(
                      children: alarms.map((alarm) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 5,
                                color: Colors.red.withOpacity(0.4),
                                offset: const Offset(0, 0),
                              ),
                            ],
                            gradient: LinearGradient(
                              colors: [Colors.red, Colors.purple.shade300],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.label,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'Makan Pagi',
                                        style: TextStyle(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                      }).toList(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
