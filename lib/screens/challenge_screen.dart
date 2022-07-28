import 'package:bmi_app/constants/constants.dart';
import 'package:bmi_app/widgets/menu_side_bar_wigdet.dart';
import 'package:flutter/material.dart';

class ChallangeScreen extends StatelessWidget {
  const ChallangeScreen({
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
                        '',
                        style: clockTextStyle.copyWith(fontSize: 64),
                      ),
                      Text(
                        '',
                        style: clockTextStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(''),
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
                        'UTC ',
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
