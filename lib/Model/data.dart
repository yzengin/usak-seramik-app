import 'package:flutter/material.dart';

class DualData {
  late dynamic primary;
  late dynamic secondary;
  DualData(this.primary, this.secondary);
}

class LabeledData<String, T> {
  String? label;
  dynamic data;
  LabeledData({
    this.label,
    this.data,
  });
}

class ColorData {
  late String label;
  late Color color;
  dynamic data;
  ColorData({
    required this.label,
    required this.color,
    this.data,
  });
}

class RangeData {
  RangeValues? value;
  RangeValues minMax;
  int division;
  RangeData({this.value, this.minMax = const RangeValues(0, 100), this.division = 10});
}

class FilterData {
  List<SearchDataModel> searchFilters;
  List<FilterDataModel> chooseFilters;
  List<RangeDataModel> rangeFilters;
  List<FilterDataModel> colorFilters;
  FilterData({
    required this.searchFilters,
    required this.chooseFilters,
    required this.rangeFilters,
    required this.colorFilters,
  });

  void toDebugPrint() {
    debugPrint('---------------------------------------------------------------------------------------------------');
    for (var element in searchFilters) {
      debugPrint('${element.filter.context.label} : ${element.controller.text}');
    }
    debugPrint('---------------------------------------------------------------------------------------------------');
    for (var element in chooseFilters) {
      debugPrint('${element.context.label} : ${element.getDataByBoolean()}');
    }
    debugPrint('---------------------------------------------------------------------------------------------------');
    for (var element in rangeFilters as List<RangeDataModel<String, RangeValues>>) {
      debugPrint('${element.context.label} : (${element.context.data.value.start},${element.context.data.value.end})');
    }
    debugPrint('---------------------------------------------------------------------------------------------------');
  }
}

class SearchDataModel {
  FilterDataModel filter;
  TextEditingController controller;
  FocusNode node;
  SearchDataModel({required this.filter, required this.controller, required this.node});
}

class FilterDataModel {
  LabeledData context;
  List<FilterDataModel>? filters;
  FilterDataModel({required this.context, this.filters});
  List getValues() {
    List values = [];
    if (filters != null) {
      for (var element in filters!) {
        values.add(element.context);
      }
    }
    return values;
  }

  bool? getDataByBoolean() {
    switch (context.data.toInt()) {
      case -1:
        return null;
      case 0:
        return false;
      case 1:
        return true;
      default:
        return null;
    }
  }
}

class RangeDataModel<String, RangeValues> {
  LabeledData<String, RangeData> context;
  RangeDataModel({required this.context});
}
