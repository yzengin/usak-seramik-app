import 'package:flutter/material.dart';

class DualData {
  late dynamic primary;
  late dynamic secondary;
  DualData(this.primary, this.secondary);
}

class LabeledData<String, T> {
  String? label;
  dynamic data;
  bool isColor;
  bool translate;
  LabeledData({this.label, this.data, this.isColor = false, this.translate = true});
}

class RangeData {
  RangeValues? value;
  RangeValues minMax;
  int division;
  bool preferSlider;
  RangeData({this.value, this.minMax = const RangeValues(0, 100), this.division = 10, this.preferSlider = true});
}

class FilterData {
  List<SearchDataModel>? searchFilters;
  List<ChooiceDataModel>? chooseFilters;
  List<RangeDataModel>? rangeFilters;
  FilterData({
    this.searchFilters,
    this.chooseFilters,
    this.rangeFilters,
  });

  void toDebugPrint() {
    debugPrint('---------------------------------------------------------------------------------------------------');
    if (searchFilters != null) {
      for (var element in searchFilters!) {
        debugPrint('${element.filter.context.label} : ${element.controller.text}');
      }
    }
    debugPrint('----------------------------------------CHOose-----------------------------------------------------------');
    if (chooseFilters != null) {
      for (var element in chooseFilters!) {
        if (element.multiple) {
          debugPrint('${element.context.label} : ${element.context.data.toString()}');
        } else {
          debugPrint('${element.context.label} : ${element.getDataByBoolean()}');
        }
      }
    }
    debugPrint('---------------------------------------------------------------------------------------------------');
    if (rangeFilters != null) {
      for (var element in rangeFilters as List<RangeDataModel<String, RangeValues>>) {
        if (element.context.data.preferSlider) {
          debugPrint('${element.context.label} : (${element.context.data.value.start},${element.context.data.value.end})');
        } else {
          debugPrint('${element.context.label} : (${element.context.data.value.start},${element.context.data.value.end})');
        }
      }
    }
    debugPrint('---------------------------------------------------------------------------------------------------');
  }
}

class SearchDataModel {
  ChooiceDataModel filter;
  TextEditingController controller;
  FocusNode node;
  SearchDataModel({required this.filter, required this.controller, required this.node});
}

class ChooiceDataModel {
  LabeledData context;
  List<ChooiceDataModel>? filters;
  bool multiple;
  ChooiceDataModel({required this.context, this.filters, this.multiple = false});
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
