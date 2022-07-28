import 'package:bmi_app/args/args_per_screen.dart';
import 'package:bmi_app/routes/app_pages.dart';
import 'package:bmi_app/widgets/main_menu_button.dart';
import 'package:bmi_app/widgets/menu_button_widget.dart';
import 'package:flutter/material.dart';

class MenuSideBarWidget extends StatelessWidget {
  const MenuSideBarWidget({
    Key? key,
    required this.paddingTop,
    required this.spacerMenu,
  }) : super(key: key);

  final double paddingTop;
  final double spacerMenu;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: paddingTop + 10),
        const MainMenuButton(),
        SizedBox(height: spacerMenu),
        MenuButton(
          icon: Icons.sports_gymnastics,
          title: Args.challange,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.challangeScreen,
              arguments: Args.challange,
            );
          },
        ),
        MenuButton(
          icon: Icons.watch_later_outlined,
          title: Args.eatTime,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.setEatScreen,
              arguments: Args.eatTime,
            );
          },
        ),
        MenuButton(
          icon: Icons.food_bank_outlined,
          title: Args.addEatAlarm,
          onTap: () {
            Navigator.pushNamed(
              context,
              Routes.addEatAlarmScreen,
              arguments: Args.addEatAlarm,
            );
          },
        ),
        const Spacer(
          flex: 2,
        ),
      ],
    );
  }
}
