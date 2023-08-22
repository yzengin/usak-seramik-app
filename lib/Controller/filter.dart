import 'package:flutter/material.dart';
import 'package:usak_seramik_app/View/style/colors.dart';

import '../Model/data.dart';

FilterData testFilter = FilterData(searchFilters: _search, chooseFilters: _choose);

List<SearchDataModel> _search = [
  SearchDataModel(filter: ChooiceDataModel(context: LabeledData(data: 0, label: 'searchProduct')), controller: TextEditingController(), node: FocusNode()),
];

List<ChooiceDataModel> _choose = [
  ChooiceDataModel(context: LabeledData(data: [], label: 'urunTuru'), filters: _productType, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'kullanimAlani'), filters: _usageArea, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'sizes'), filters: _sizes, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'colors'), filters: _colorFilter, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'brightness'), filters: _brightness, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'texture'), filters: _textures, multiple: true),
];

// List<RangeDataModel<String, RangeValues>> _range = [
//   RangeDataModel(context: LabeledData(data: RangeData(value: const RangeValues(0, 100)), label: 'Range Slider')),
//   RangeDataModel(context: LabeledData(data: RangeData(value: const RangeValues(0, 100), preferSlider: false), label: 'Range Input')),
// ];

List<ChooiceDataModel> binaryFilter = [
  ChooiceDataModel(
      context: LabeledData(
    data: -1,
    label: 'Tümü',
  )),
  ChooiceDataModel(context: LabeledData(data: 0, label: 'Pasif')),
  ChooiceDataModel(context: LabeledData(data: 1, label: 'Aktif')),
];

List<ChooiceDataModel> _colorFilter = [
  ChooiceDataModel(context: LabeledData(data: AppColors.filter0, label: 'siyah', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter1, label: 'mavi', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter2, label: 'antrasit', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter3, label: 'kahve', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter4, label: 'gri', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter5, label: 'ekru', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter6, label: 'bej', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter7, label: 'kirmizi', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter8, label: 'bone', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter9, label: 'dekor', isColor: true)),
  ChooiceDataModel(context: LabeledData(data: AppColors.filter10, label: 'beyaz', isColor: true)),
];

List<ChooiceDataModel> _productType = [
  ChooiceDataModel(context: LabeledData(data: 0, label: 'tezgahArasi'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 1, label: 'takimUrunler'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 2, label: 'yerUrunler'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 3, label: 'granitler'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 4, label: 'disMekanSerileri'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 5, label: 'parkeUrunleri'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 6, label: 'havuzUrunleri'), multiple: true),
];
List<ChooiceDataModel> _usageArea = [
  ChooiceDataModel(context: LabeledData(data: 0, label: 'yasamAlani'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 1, label: 'mutfak'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 2, label: 'banyo'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 3, label: 'disMekan'), multiple: true),
];

List<ChooiceDataModel> _sizes = [
  ChooiceDataModel(context: LabeledData(data: 0, label: '20,5x60', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 1, label: '30x60', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 2, label: '30x80', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 3, label: '33x33', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 4, label: '45x45', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 5, label: '48x48', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 6, label: '60x120', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 7, label: '60x60', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 8, label: '80x80', translate: false), multiple: true),
];

List<ChooiceDataModel> _brightness = [
  ChooiceDataModel(context: LabeledData(data: 0, label: 'bright'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 1, label: 'mat'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 2, label: 'fullL'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 3, label: 'semiL'), multiple: true),
];

List<ChooiceDataModel> _textures = [
  ChooiceDataModel(context: LabeledData(data: 0, label: 'decor'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 1, label: 'concrete'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 2, label: 'marble'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 3, label: 'stone'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 4, label: 'ahsapMermer'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 5, label: 'wood'), multiple: true),
];
