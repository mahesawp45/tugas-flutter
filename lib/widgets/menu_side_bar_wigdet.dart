import 'package:flutter/material.dart';

class MenuSideBarWidget extends StatefulWidget {
  MenuSideBarWidget({
    Key? key,
    required this.paddingTop,
    required this.spacerMenu,
    required this.pageController,
    this.index,
  }) : super(key: key);

  final double paddingTop;
  final double spacerMenu;
  final PageController pageController;

  int? index;

  @override
  State<MenuSideBarWidget> createState() => _MenuSideBarWidgetState();
}

class _MenuSideBarWidgetState extends State<MenuSideBarWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
