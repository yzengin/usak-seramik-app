import 'package:flutter/material.dart';
import 'package:usak_seramik_app/View/style/colors.dart';
import '../model/data.dart';

FilterData testFilter = FilterData(searchFilters: _search, chooseFilters: _choose, rangeFilters: _range, colorFilters: colorFilter);

List<SearchDataModel> _search = [
  SearchDataModel(filter: FilterDataModel(context: LabeledData(data: 0, label: 'Arama 1')), controller: TextEditingController(), node: FocusNode()),
  SearchDataModel(filter: FilterDataModel(context: LabeledData(data: 0, label: 'Arama 2')), controller: TextEditingController(), node: FocusNode()),
];

List<FilterDataModel> _choose = [
  FilterDataModel(context: LabeledData(data: -1, label: 'Seçenek 1'), filters: binaryFilter),
  FilterDataModel(context: LabeledData(data: -1, label: 'Seçenek 2'), filters: binaryFilter),
];

List<RangeDataModel<String, RangeValues>> _range = [
  RangeDataModel(context: LabeledData(data: RangeData(value: const RangeValues(0, 100)), label: 'Aralık 1')),
  RangeDataModel(context: LabeledData(data: RangeData(value: const RangeValues(20, 70)), label: 'Aralık 2')),
];

List<FilterDataModel> binaryFilter = [
  FilterDataModel(context: LabeledData(data: -1, label: 'Tümü')),
  FilterDataModel(context: LabeledData(data: 0, label: 'Pasif')),
  FilterDataModel(context: LabeledData(data: 1, label: 'Aktif')),
];

List<FilterDataModel> colorFilter = [
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter0, label: 'Siyah'), label: 'Siyah')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter1, label: 'Mavi'), label: 'Mavi')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter2, label: 'Antrasit'), label: 'Antrasit')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter3, label: 'Kahve'), label: 'Kahve')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter4, label: 'Gri'), label: 'Gri')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter5, label: 'Ekru'), label: 'Ekru')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter6, label: 'Bej'), label: 'Bej')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter7, label: 'Kırmızı'), label: 'Kırmızı')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter8, label: 'Bone'), label: 'Bone')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter9, label: 'Dekor'), label: 'Dekor')),
  FilterDataModel(context: LabeledData(data: ColorData(color: AppColors.filter10, label: 'Beyaz'), label: 'Beyaz')),
];
