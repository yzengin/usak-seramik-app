// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'dart:math';
import '/view/style/glow.dart';
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
  String translete(String? keyw) {
    try {
      return LocalizationController.of(this)!.translate(keyw)!;
    } catch (e) {
      return "";
    }
  }

  ThemeData get theme => Theme.of(this);
  TextStyle get textStyle => Theme.of(this).textTheme.bodyMedium!;
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colors => Theme.of(this).colorScheme;
}

extension WidgetExtension on Widget {
  Widget wrapPaddingAll(double distance) => Padding(padding: EdgeInsets.all(distance), child: this);
  Widget wrapPaddingHorizontal(double distance) => Padding(padding: EdgeInsets.symmetric(horizontal: distance), child: this);
  Widget wrapPaddingVertical(double distance) => Padding(padding: EdgeInsets.symmetric(vertical: distance), child: this);
  Widget wrapPaddingTop(double distance) => Padding(padding: EdgeInsets.only(top: distance), child: this);
  Widget wrapPaddingBottom(double distance) => Padding(padding: EdgeInsets.only(bottom: distance), child: this);
  Widget wrapPaddingLeft(double distance) => Padding(padding: EdgeInsets.only(left: distance), child: this);
  Widget wrapPaddingRight(double distance) => Padding(padding: EdgeInsets.only(right: distance), child: this);
  Widget wrapPaddingParametric(EdgeInsetsGeometry edge) => Padding(padding: edge, child: this);
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
  String firstLetterUpperCase() {
    List<String> words = split(' ');
    List<String> res = [];
    for (var element in words) {
      res.add("${element[0].toUpperCase()}${element.substring(1).toLowerCase()}");
    }
    return res.join(' ');
  }

  String head() {
    if (this.isNotEmpty) {
      final parts = this.split(' ').where((part) => part.isNotEmpty);
      final initials = parts.map((part) => part[0].toUpperCase()).join('');
      return initials;
    } else {
      return "?";
    }
  }

  Color hexToColor() {
    String formattedHex = "FF" + this.replaceAll("#", "");
    return Color(int.parse(formattedHex, radix: 16));
  }
}

String translateData(dynamic data) {
  String locale = '';

  locale = localeNotifier.value!.languageCode;
  if (locale == 'tr') {
    return data.tr;
  } else {
    if (locale == 'en') {
      return data.en;
    }
  }

  return data.tr;
}

String translateImage(dynamic data) {
  String locale = '';

  locale = localeNotifier.value!.languageCode;
  if (locale == 'tr') {
    return data.trImage;
  } else {
    if (locale == 'en') {
      return data.enImage;
    }
  }

  return data.tr;
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
  double reduceRange01(double max, double min) {
    return (this - min) * (1 - 0) / (max - min) + 0;
  }
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

extension ColorExtensions on Color {
  Color mix({Color mixing = Colors.white, double rate = 0.5}) => Color.lerp(this, mixing, rate)!;
  bool isDarkContrast() => ThemeData.estimateBrightnessForColor(this) == Brightness.dark;
  bool isLightContrast() => ThemeData.estimateBrightnessForColor(this) == Brightness.light;
  Color getContrastColor() => isDarkContrast() ? Colors.white : Colors.black;
  bool contrastCheck(Color targetColor, {double threshold = 0.5}) => (luminance - targetColor.luminance).abs() >= threshold;
  double get luminance => ((0.299 * red + 0.587 * green + 0.114 * blue) / 255).toDoubleAsFixed();
  Color increaseLuminance({double target = 0.4}) {
    final currentLuminance = luminance;
    final delta = target - currentLuminance;
    final newLuminance = (currentLuminance + delta).clamp(0.0, 1.0);
    return HSLColor.fromColor(this).withLightness(newLuminance).toColor();
  }

  Color increaseSaturation({double target = 0.6}) {
    final hslColor = HSLColor.fromColor(this);
    final newSaturation = (hslColor.saturation + value).clamp(0.0, 1.0);
    return hslColor.withSaturation(newSaturation).toColor();
  }

  Color complementaryColor() {
    final hslColor = HSLColor.fromColor(this);
    final complementaryHue = (hslColor.hue + 180.0) % 360.0;
    return HSLColor.fromAHSL(1.0, complementaryHue, hslColor.saturation, hslColor.lightness).toColor();
  }

  Color rotateColor(double angleInDegrees) {
    final hslColor = HSLColor.fromColor(this);
    final newHue = (hslColor.hue + angleInDegrees) % 360.0;
    return HSLColor.fromAHSL(1.0, newHue, hslColor.saturation, hslColor.lightness).toColor();
  }

  Color toPastelColor({double factor = 0.6}) {
    final red = ((this.red * factor) + (255 * (1.0 - factor))).toInt();
    final green = ((this.green * factor) + (255 * (1.0 - factor))).toInt();
    final blue = ((this.blue * factor) + (255 * (1.0 - factor))).toInt();
    return Color.fromARGB(255, red, green, blue);
  }

  Color toNeonColor({double factor = 1.0}) {
    final red = (this.red + (255 * factor)).clamp(0, 255).toInt();
    final green = (this.green + (255 * factor)).clamp(0, 255).toInt();
    final blue = (this.blue + (255 * factor)).clamp(0, 255).toInt();
    return Color.fromARGB(255, red, green, blue);
  }
}
