// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import '/view/style/glow.dart';
import '/view/widget/utility/copy_on_tap.dart';
import 'package:intl/intl.dart';

import 'localization.dart';

extension BuildContextExtensions on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;
  double get paddingTop => mediaQuery.padding.top;
  double get paddingBottom => mediaQuery.padding.bottom;
  double get paddingBottomPlace => mediaQuery.padding.bottom != 0 ? mediaQuery.padding.bottom : 20;
  Size get resolution => WidgetsBinding.instance.window.physicalSize;
  bool get isMobile => mediaQuery.size.width < 850 && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
  String? get routeName => ModalRoute.of(this)!.settings.name;
  List<dynamic>? get routeArguments => ModalRoute.of(this)!.settings.arguments as List<dynamic>?;
  String translete(String? keyw) => LocalizationController.of(this)!.translate(keyw)!;
  ThemeData get theme => Theme.of(this);
}

extension WidgetExtension on Widget {
  Widget wrapPaddingAll(double distance) => Padding(padding: EdgeInsets.all(distance), child: Center(child: this));
  Widget wrapPaddingHorizontal(double distance) => Padding(padding: EdgeInsets.symmetric(horizontal: distance), child: Center(child: this));
  Widget wrapPaddingVertical(double distance) => Padding(padding: EdgeInsets.symmetric(vertical: distance), child: Center(child: this));
  Widget wrapPaddingTop(double distance) => Padding(padding: EdgeInsets.only(top: distance), child: this);
  Widget wrapPaddingBottom(double distance) => Padding(padding: EdgeInsets.only(bottom: distance), child: Center(child: this));
  Widget wrapPaddingLeft(double distance) => Padding(padding: EdgeInsets.only(left: distance), child: Center(child: this));
  Widget wrapPaddingRight(double distance) => Padding(padding: EdgeInsets.only(right: distance), child: Center(child: this));
  Widget wrapPaddingParametric(EdgeInsetsGeometry edge) => Padding(padding: edge, child: Center(child: this));
  Widget wrapDecoration(BoxDecoration decoration) => DecoratedBox(decoration: decoration, child: this);
  Widget wrapTextStyle(TextStyle style) => DefaultTextStyle(style: style, child: this);
  Widget wrapFixedSize(Size size) => SizedBox(height: size.height, width: size.width, child: Center(child: this));
  Widget wrapDisableGlow() => ScrollConfiguration(behavior: WithoutGlow(), child: this);
  Widget showDrawingArea({Color color = Colors.red}) => ColoredBox(color: color.withOpacity(.5), child: this);
}

extension StringExtensions on String {
  String whitespace() => " $this ";
  String addQuotes() => "'$this'";
  String addSymbolBefore({String symbol = ''}) => "$symbol $this";
  String addSymbolAfter({String symbol = ''}) => "$this $symbol";
  Widget copyOnTap({String? description, bool showCopyIcon = true, TextStyle? style, Color? color, Duration duration = const Duration(milliseconds: 500)}) => CopyOnTap(this, style: style, barrierColor: color, delay: duration, description: description, showCopyIcon: showCopyIcon);
}

extension DoubleExtensions on double {
  double toDegrees() => this * 180 / pi;
  double toRadians() => this * pi / 180;
  double toDoubleAsFixed({int digit = 2}) => double.parse(toStringAsFixed(digit));
  String addCurrencySymbolBefore({String currencySymbol = 'TL', int digit = 2}) => '$currencySymbol ${toStringAsFixed(digit)}';
  String addCurrencySymbolAfter({String currencySymbol = 'TL', int digit = 2}) => '${toStringAsFixed(digit)} $currencySymbol';
  bool isInRange(double start, double end) => this >= start && this <= end;
  double reduceRange(double max, double min) => (this - min) * (1 - 0) / (max - min) + 0;

  int reduceRange5({bool isFloat = true}) {
    if (this >= 0 && this < 0.2 * (isFloat ? 1 : 100)) {
      return 1;
    } else if (this >= 0.2 * (isFloat ? 1 : 100) && this < 0.4 * (isFloat ? 1 : 100)) {
      return 2;
    } else if (this >= 0.4 * (isFloat ? 1 : 100) && this < 0.6 * (isFloat ? 1 : 100)) {
      return 3;
    } else if (this >= 0.6 * (isFloat ? 1 : 100) && this < 0.8 * (isFloat ? 1 : 100)) {
      return 4;
    } else if (this >= 0.8 * (isFloat ? 1 : 100) && this <= 1 * (isFloat ? 1 : 100)) {
      return 5;
    } else {
      return 0;
    }
  }

  double reduceRange5Half({bool isFloat = true}) {
    if (this >= 0 && this < 0.1 * (isFloat ? 1 : 100)) {
      return 0.5;
    } else if (this >= 0.1 * (isFloat ? 1 : 100) && this < 0.2 * (isFloat ? 1 : 100)) {
      return 1;
    } else if (this >= 0.2 * (isFloat ? 1 : 100) && this < 0.3 * (isFloat ? 1 : 100)) {
      return 1.5;
    } else if (this >= 0.3 * (isFloat ? 1 : 100) && this < 0.4 * (isFloat ? 1 : 100)) {
      return 2;
    } else if (this >= 0.4 * (isFloat ? 1 : 100) && this < 0.5 * (isFloat ? 1 : 100)) {
      return 2.5;
    } else if (this >= 0.5 * (isFloat ? 1 : 100) && this < 0.6 * (isFloat ? 1 : 100)) {
      return 3;
    } else if (this >= 0.6 * (isFloat ? 1 : 100) && this <= 0.7 * (isFloat ? 1 : 100)) {
      return 3.5;
    } else if (this >= 0.7 * (isFloat ? 1 : 100) && this <= 0.8 * (isFloat ? 1 : 100)) {
      return 4;
    } else if (this >= 0.8 * (isFloat ? 1 : 100) && this <= 0.9 * (isFloat ? 1 : 100)) {
      return 4.5;
    } else if (this >= 0.9 * (isFloat ? 1 : 100) && this <= 1 * (isFloat ? 1 : 100)) {
      return 5;
    } else {
      return 0;
    }
  }
}

extension IntExtensions on int {
  Duration hour() => Duration(hours: this);
  Duration minute() => Duration(minutes: this);
  Duration second() => Duration(seconds: this);
  Duration millisecond() => Duration(milliseconds: this);
}

extension DateTimeExtensions on DateTime {
  String formatddMMyyyy() => DateFormat('dd.MM.yyyy', 'tr_TR').format(this);
  String formatddMMyyyyHHmm() => DateFormat('dd.MM.yyyy HH:mm', 'tr_TR').format(this);
  String formatddMMMMyyyy() => DateFormat('dd MMMM yyyy', 'tr_TR').format(this);
  String formatEEEE() => DateFormat('EEEE', 'tr_TR').format(this);
  String formatCustom({String query = 'dd.MM.yyyy'}) => DateFormat(query, 'tr_TR').format(this);
  String formatCustomWithString({String query = 'dd MMMM yyyy'}) {
    DateFormat formatBase = DateFormat(query, 'tr_TR');
    try {
      if (addDays(2).isToday || addDays(3).isToday) {
        return "Geçtiğimiz ${DateFormat('EEEE', 'tr_TR').format(this)}";
      } else if (addDays(1).isToday) {
        return "Dün";
      } else if (isToday) {
        return "Bugün";
      } else if (addDays(-1).isToday) {
        return "Yarın";
      } else if (addDays(-2).isToday || addDays(-3).isToday) {
        return "Önümüzdeki ${DateFormat('EEEE', 'tr_TR').format(this)}";
      } else {
        return formatBase.format(this);
      }
    } on Exception catch (e) {
      return '$e';
    }
  }

  DateTime addDays(int quantity) => add(Duration(days: quantity));
  bool get isToday {
    DateTime now = DateTime.now();
    return (day == now.day && month == now.month && year == now.year);
  }
}
