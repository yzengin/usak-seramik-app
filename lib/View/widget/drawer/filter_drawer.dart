import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/ProductFeatures/name_data_entity.dart';

import '../../../Model/data.dart';
import '../../../Rest/Controller/Product/product_controller.dart';

class FilterDrawer extends StatefulWidget {
  const FilterDrawer({super.key, required this.model, this.searchResultPage});
  final FilterData model;
  final bool? searchResultPage;

  @override
  State<FilterDrawer> createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: context.width * 0.9,
      backgroundColor: context.colors.onBackground,
      child: Padding(
        padding: EdgeInsets.only(top: context.paddingTop + 10, left: 20),
        child: Column(
          children: [
            (widget.model.searchFilters == null)
                ? const SizedBox()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: widget.model.searchFilters!.length,
                    itemBuilder: (context, index) {
                      final data = widget.model.searchFilters![index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(context.translete(data.filter.context.label)).wrapPaddingLeft(20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: TextField(
                                    controller: data.controller,
                                    focusNode: data.node,
                                    textInputAction: index == widget.model.searchFilters!.length - 1 ? TextInputAction.done : TextInputAction.next,
                                    style: context.textStyle,
                                    decoration: InputDecoration(
                                      hintText: context.translete('search').toLowerCase(),
                                      hintStyle: context.textStyle,
                                      border: InputBorder.none,
                                      floatingLabelAlignment: FloatingLabelAlignment.center,
                                    ),
                                  ),
                                ).wrapPaddingTop(10),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
            Text(context.translete('filterDescription'), style: context.textStyle.copyWith(fontSize: 13)).wrapPaddingVertical(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    (widget.model.chooseFilters == null)
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: widget.model.chooseFilters!.length,
                            itemBuilder: (context, index) {
                              final data = widget.model.chooseFilters![index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(context.translete(data.context.label)).wrapPaddingLeft(20),
                                    SizedBox(
                                      height: kToolbarHeight,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget.model.chooseFilters![index].filters!.length,
                                        itemBuilder: (BuildContext context, int indexSub) {
                                          final subData = widget.model.chooseFilters![index].filters![indexSub];
                                          if (data.multiple) {
                                            return Row(
                                              children: [
                                                FilterChip(
                                                  label: subData.context.isColor
                                                      ? Text(translateName((subData.context.label.label)))
                                                      : subData.context.translate
                                                          ? Text(translateName((subData.context.label)))
                                                          : Text((subData.context.label)),
                                                  labelStyle: subData.context.isColor ? context.theme.chipTheme.labelStyle?.copyWith(color: (subData.context.label.data as Color).getContrastColor()) : context.theme.chipTheme.labelStyle,
                                                  checkmarkColor: subData.context.isColor ? (subData.context.label.data as Color).getContrastColor() : context.theme.iconTheme.color,
                                                  selected: data.context.data.contains(subData.context.data),
                                                  backgroundColor: subData.context.isColor ? (subData.context.label.data as Color) : context.theme.chipTheme.backgroundColor,
                                                  selectedColor: subData.context.isColor ? (subData.context.label.data as Color) : context.theme.chipTheme.selectedColor,
                                                  onSelected: (value) {
                                                    if (data.context.data.contains(subData.context.data)) {
                                                      data.context.data.remove(subData.context.data);
                                                    } else {
                                                      data.context.data.add(subData.context.data);
                                                    }
                                                    // data.context.data = subData.context.data;
                                                    setState(() {});
                                                    // model.chooseFilters[indexSub].context.data = subData;
                                                    // setState(() {});
                                                  },
                                                ).wrapPaddingRight(10),
                                              ],
                                            );
                                          } else {
                                            return FilterChip(
                                              label: Text(subData.context.label),
                                              selected: data.context.data == subData.context.data,
                                              onSelected: (value) {
                                                data.context.data = subData.context.data;
                                                setState(() {});
                                                // model.chooseFilters[indexSub].context.data = subData;
                                                // setState(() {});
                                              },
                                            ).wrapPaddingRight(10);
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                    (widget.model.rangeFilters == null)
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: widget.model.rangeFilters!.length,
                            itemBuilder: (context, index) {
                              final data = widget.model.rangeFilters![index];
                              TextEditingController minController = TextEditingController();
                              TextEditingController maxController = TextEditingController();
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${data.context.label}").wrapPaddingLeft(20),
                                    if (!data.context.data.preferSlider)
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Material(
                                                color: context.colors.shadow,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kToolbarHeight)),
                                                child: TextField(
                                                  controller: minController,
                                                  onChanged: (value) {
                                                    data.context.data.value = new RangeValues(double.parse(value), data.context.data.value.end);
                                                  },
                                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                  decoration: InputDecoration(
                                                    hintText: context.translete('min'),
                                                    hintStyle: context.textStyle,
                                                    border: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    floatingLabelAlignment: FloatingLabelAlignment.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Material(
                                                color: context.colors.shadow,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kToolbarHeight)),
                                                child: TextField(
                                                  controller: maxController,
                                                  onChanged: (value) {
                                                    data.context.data.value = new RangeValues(data.context.data.value.start, double.parse(value));
                                                  },
                                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                  decoration: InputDecoration(
                                                    hintText: context.translete('max'),
                                                    hintStyle: context.textStyle,
                                                    border: InputBorder.none,
                                                    enabledBorder: InputBorder.none,
                                                    focusedBorder: InputBorder.none,
                                                    floatingLabelAlignment: FloatingLabelAlignment.center,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (data.context.data.preferSlider)
                                      Row(
                                        children: [
                                          Text("${data.context.data.minMax.start.toInt()}"),
                                          Expanded(
                                            child: RangeSlider(
                                              values: data.context.data.value,
                                              onChangeEnd: (value) {
                                                data.context.data.value = new RangeValues(value.start, value.end);
                                                setState(() {});
                                              },
                                              onChangeStart: (value) {
                                                data.context.data.value = new RangeValues(value.start, value.end);
                                                setState(() {});
                                              },
                                              onChanged: (RangeValues value) {
                                                data.context.data.value = new RangeValues(value.start, value.end);
                                                setState(() {});
                                              },
                                              min: data.context.data.minMax.start,
                                              max: data.context.data.minMax.end,
                                              divisions: data.context.data.division,
                                              labels: RangeLabels("${data.context.data.value.start.toInt()}", "${data.context.data.value.end.toInt()}"),
                                            ),
                                          ),
                                          Text("${data.context.data.minMax.end.toInt()}"),
                                        ],
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: ElevatedButton(
                          onPressed: () {
                            print('GELENN METN --- ${widget.model.searchFilters![0].controller.text}');
                            String nameStr = "${widget.model.searchFilters![0].controller.text}";
                            List<int>? urunTuru = returnDataSelected(widget.model.chooseFilters![0].context.data, "Ürün Türü - Product Type");
                            List<int>? kullanimAlani = returnDataSelected(widget.model.chooseFilters![1].context.data, "Kullanım Alanı - Usage Area");
                            List<int>? sizes = returnDataSelected(widget.model.chooseFilters![2].context.data, "Ebatlar - Sizes");
                            List<int>? colors = returnDataSelected(widget.model.chooseFilters![3].context.data, "Renkler- Colors");
                            List<int>? brightness = returnDataSelected(widget.model.chooseFilters![4].context.data, "Parlaklık - Glosses");
                            List<int>? texture = returnDataSelected(widget.model.chooseFilters![5].context.data, "Doku - Surfaces");

                            ProductAttributesSearch productAttributesSearch = ProductAttributesSearch(
                              name: nameStr,
                              productTypeId: urunTuru!,
                              productUsagesId: kullanimAlani!,
                              faceSizeId: sizes!,
                              faceColorId: colors!,
                              faceGlossId: brightness!,
                              faceSurfaceId: texture!,
                              faceThicknessId: [],
                              faceStructureId: [],
                            );
                            Provider.of<ProductController>(context, listen: false).getProductSearchController(page: 0, productAttributesSearch);
                            Navigator.pop(context);
                            if (!widget.searchResultPage!) {
                              Navigator.pushNamed(context, AppRoutes.search_result_page);
                            }
                          },
                          child: Text(context.translete('search')))
                      .wrapPaddingRight(20)
                      .wrapPaddingVertical(20),
                ),
                Flexible(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed: () {
                        widget.model.searchFilters![0].controller.clear();
                        widget.model.chooseFilters![0].context.data.clear();
                        widget.model.chooseFilters![1].context.data.clear();
                        widget.model.chooseFilters![2].context.data.clear();
                        widget.model.chooseFilters![3].context.data.clear();
                        widget.model.chooseFilters![4].context.data.clear();
                        widget.model.chooseFilters![5].context.data.clear();
                        setState(() {

                        });
                        Provider.of<ProductController>(context, listen: false).getProductSearchController(page: 0, ProductAttributesSearch(
                          name: "",
                          faceColorId: [],
                          faceSizeId: [],
                          faceSurfaceId: [],
                          faceGlossId: [],
                          faceThicknessId: [],
                          faceStructureId: [],
                          productTypeId: [],
                          productUsagesId: [],
                        ));
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.cleaning_services_rounded)).wrapPaddingRight(10),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  List<int>? returnDataSelected(List gelenData, String title) {
    List<int> myIntListNew = [];
    try {
      try {
        List<int> myIntList = List<int>.from(gelenData.map((e) {
          if (e is int) {
            return e;
          } else {
            throw Exception('Listede int olmayan bir tür bulundu.');
          }
        }));
        print('#### $title-->: $myIntList');
        myIntListNew = myIntList;
      } catch (e) {
        print('$title-->:Dönüşüm sırasında hata oluştu: $e');
      }
    } catch (e) {
      debugPrint("$title-->: ReturnDataSelectFilter  Error-->  $e");
    }

    return myIntListNew;
  }
}
