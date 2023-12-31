import 'package:flutter/material.dart';
import 'package:usak_seramik_app/View/style/colors.dart';

import '../Model/data.dart';

FilterData testFilter = FilterData(searchFilters: _search, chooseFilters: _choose);
FilterData productFilter = FilterData(chooseFilters: [], rangeFilters: [], searchFilters: []);

List<SearchDataModel> _search = [
  SearchDataModel(filter: ChooiceDataModel(context: LabeledData(data: 0, label: 'searchProduct')), controller: TextEditingController(), node: FocusNode()),
];

List<ChooiceDataModel> _choose = [
  ChooiceDataModel(context: LabeledData(data: [], label: 'urunTuru'), filters: productTypeFilter, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'kullanimAlani'), filters: usageAreaFilter, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'sizes'), filters: sizesFilter, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'colors'), filters: colorFilter, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'brightness'), filters: glossFilter, multiple: true),
  ChooiceDataModel(context: LabeledData(data: [], label: 'texture'), filters: surfaceFilter, multiple: true),
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
  ChooiceDataModel(context: LabeledData(data: 18, label: LabeledData(data: AppColors.filter0, label: 'siyah'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 17, label: LabeledData(data: AppColors.filter1, label: 'mavi'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 9, label: LabeledData(data: AppColors.filter2, label: 'antrasit'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 15, label: LabeledData(data: AppColors.filter3, label: 'kahve'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 14, label: LabeledData(data: AppColors.filter4, label: 'gri'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 19, label: LabeledData(data: AppColors.filter5, label: 'ekru'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 10, label: LabeledData(data: AppColors.filter6, label: 'bej'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 16, label: LabeledData(data: AppColors.filter7, label: 'kirmizi'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 12, label: LabeledData(data: AppColors.filter8, label: 'bone'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 13, label: LabeledData(data: AppColors.filter9, label: 'dekor'), isColor: true)),
  ChooiceDataModel(context: LabeledData(data: 11, label: LabeledData(data: AppColors.filter10, label: 'beyaz'), isColor: true)),
];

List<ChooiceDataModel> _productType = [
  ChooiceDataModel(context: LabeledData(data: 8, label: 'tezgahArasi'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 5, label: 'takimUrunler'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 7, label: 'yerUrunler'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 11, label: 'granitler'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 6, label: 'disMekanSerileri'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 9, label: 'parkeUrunleri'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 10, label: 'havuzUrunleri'), multiple: true),
];
List<ChooiceDataModel> _usageArea = [
  ChooiceDataModel(context: LabeledData(data: 8, label: 'yasamAlani'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 7, label: 'mutfak'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 6, label: 'banyo'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 9, label: 'disMekan'), multiple: true),
];

List<ChooiceDataModel> _sizes = [
  ChooiceDataModel(context: LabeledData(data: 5, label: '20,5x60', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 6, label: '30x60', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 1, label: '30x80', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 7, label: '33x33', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 8, label: '45x45', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 2, label: '48x48', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 3, label: '60x120', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 9, label: '60x60', translate: false), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 10, label: '80x80', translate: false), multiple: true),
];

List<ChooiceDataModel> _brightness = [
  ChooiceDataModel(context: LabeledData(data: 4, label: 'bright'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 5, label: 'mat'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 6, label: 'fullL'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 7, label: 'semiL'), multiple: true),
];

List<ChooiceDataModel> _textures = [
  ChooiceDataModel(context: LabeledData(data: 6, label: 'decor'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 5, label: 'concrete'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 7, label: 'marble'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 8, label: 'stone'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 9, label: 'ahsapMermer'), multiple: true),
  ChooiceDataModel(context: LabeledData(data: 4, label: 'wood'), multiple: true),
];

// ---------------------------------------------------------------------------------------------------
List<ChooiceDataModel> colorFilter = [];
List<ChooiceDataModel> glossFilter = [];
List<ChooiceDataModel> sizesFilter = [];
List<ChooiceDataModel> surfaceFilter = [];
List<ChooiceDataModel> productTypeFilter = [];
List<ChooiceDataModel> usageAreaFilter = [];
