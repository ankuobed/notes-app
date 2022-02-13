import 'package:flutter/material.dart';

class Responsive {
  static const tabletMinWidth = 510;
  static const destopMinWidth = 1024;

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= destopMinWidth;
  }

  static bool isTablet(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return deviceWidth >= tabletMinWidth && destopMinWidth < destopMinWidth;
  }

  static bool isMoble(BuildContext context) {
    return MediaQuery.of(context).size.width < tabletMinWidth;
  }
}
