import 'package:flutter/material.dart';

class NavigationBarItem {
  late int id;
  late String? title;
  late String? activeIcon;
  late IconData? activeIconData;
  late String? deActiveIcon;
  late IconData? deActiveIconData;
  NavigationBarItem({
    required this.id,
    this.title,
    this.activeIcon,
    this.deActiveIcon,
    this.activeIconData,
    this.deActiveIconData,
  });
}

List<NavigationBarItem> userNavBarItems = [
  NavigationBarItem(id: 0, title: 'Home')
];
