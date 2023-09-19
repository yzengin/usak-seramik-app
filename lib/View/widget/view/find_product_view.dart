import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_features_controller.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/ProductFeatures/product_color_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/ProductFeatures/product_surface_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/ProductFeatures/product_types_entity.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/ProductFeatures/product_usage_area_entity.dart';
import 'package:usak_seramik_app/View/custom/curves.dart';

import '../../../Controller/notifiers.dart';
import '../../../Rest/Controller/Product/product_controller.dart';
import '../../../Rest/Entity/Product/ProductFeatures/name_data_entity.dart';
import '../../../view/page/mobile/main/homepage.dart';
import '../dialog/dialog.dart';

class FindProductView extends StatefulWidget {
  FindProductView({super.key});

  @override
  State<FindProductView> createState() => _FindProductViewState();
}

class _FindProductViewState extends State<FindProductView> {
  final ScrollController scrollController = ScrollController();
  final PageController findProductPageController = PageController();
  final ValueNotifier<int> showIndex = ValueNotifier<int>(-1);

  final ValueNotifier<int?> selectedProductColorId = ValueNotifier<int?>(null);
  final ValueNotifier<int?> selectedProductSurfaceId = ValueNotifier<int?>(null);
  final ValueNotifier<int?> selectedProductTypesId = ValueNotifier<int?>(null);
  final ValueNotifier<int?> selectedProductUsageAreaId = ValueNotifier<int?>(null);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProductColorData productColorData = Provider.of<ProductFeaturesController>(context, listen: true).productColorData;
    ProductSurfaceData productSurfaceData = Provider.of<ProductFeaturesController>(context, listen: true).productSurfaceData;
    ProductTypesData productTypesData = Provider.of<ProductFeaturesController>(context, listen: true).productTypesData;
    ProductUsageAreaData productUsageAreaData = Provider.of<ProductFeaturesController>(context, listen: true).productUsageAreaData;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.only(top: context.paddingTop * 1.5, left: 20, right: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => pageViewController.previousPage(duration: autoPlayAnimationDuration, curve: AppCurves.overshoot()),
                child: Row(children: [
                  Animate(effects: [MoveEffect(duration: autoPlayAnimationDuration, delay: 100.milliseconds, begin: Offset(0, -5), end: Offset(0, 5))], onComplete: (controller) => controller.repeat(reverse: true), child: Icon(FontAwesomeIcons.chevronUp)).wrapPaddingHorizontal(10),
                  Expanded(child: Text(context.translete('showreelButton')).wrapPaddingLeft(20)),
                ]),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Column(children: [
                  buildDropdown(
                    FontAwesomeIcons.personShelter,
                    'kullanimAlani',
                    productUsageAreaData.data,  // Özel bir dataList
                    selectedProductUsageAreaId,
                  ),
                  buildDropdown(
                    FontAwesomeIcons.layerGroup,
                    'urunTuru',
                    productTypesData.data,  // Özel bir dataList
                    selectedProductTypesId,
                  ),
                  buildDropdown(
                    FontAwesomeIcons.swatchbook,
                    'urunDokusu',
                    productSurfaceData.data,  // Özel bir dataList
                    selectedProductSurfaceId,
                  ),
                  buildDropdown(
                    FontAwesomeIcons.palette,
                    'urunRengi',
                    productColorData.data,  // Özel bir dataList
                    selectedProductColorId,
                  ),
                ],),
              ),
              ElevatedButton(
                      onPressed: () {
                        if(selectedProductUsageAreaId.value== null && selectedProductTypesId.value== null && selectedProductColorId.value== null && selectedProductSurfaceId.value== null){
                          appDialog(context, message: context.translete("showCaseFilterMessage"), dialogType: DialogType.failed);
                          return;
                        }
                        List<int>? productUsageAreaIds = [];
                        List<int>? productTypeIds = [];
                        List<int>? productColorIds = [];
                        List<int>? productSurfacesIds = [];
                        if(selectedProductUsageAreaId.value!=null){
                          productUsageAreaIds.add(selectedProductUsageAreaId.value!);
                        }
                        if(selectedProductTypesId.value!=null){
                          productTypeIds.add(selectedProductTypesId.value!);
                        }
                        if(selectedProductColorId.value!=null){
                          productColorIds.add(selectedProductColorId.value!);
                        }
                        if(selectedProductSurfaceId.value!=null){
                          productSurfacesIds.add(selectedProductSurfaceId.value!);
                        }

                        ProductAttributesSearch productAttributesSearch = ProductAttributesSearch(
                          productTypeId: productTypeIds,
                          productUsagesId: productUsageAreaIds,
                          faceColorId: productColorIds,
                          faceSurfaceId: productSurfacesIds,
                          faceThicknessId: [],
                          faceStructureId: [],
                          faceSizeId: [],
                          faceGlossId: [],
                        );
                        Provider.of<ProductController>(context, listen: false).getProductSearchController(page: 0, productAttributesSearch);
                        Navigator.pushNamed(context, AppRoutes.search_result_page);
                      },
                      child: Text(context.translete("search")))
                  .wrapPaddingVertical(20),
              GestureDetector(
                onTap: () => pageViewController.nextPage(duration: autoPlayAnimationDuration, curve: AppCurves.overshoot()),
                child: Row(children: [
                  Animate(effects: [MoveEffect(duration: autoPlayAnimationDuration, delay: 100.milliseconds, begin: Offset(0, -5), end: Offset(0, 5))], onComplete: (controller) => controller.repeat(reverse: true), child: Icon(FontAwesomeIcons.chevronDown)).wrapPaddingHorizontal(10),
                  Expanded(child: Text(context.translete('productTextureButton')).wrapPaddingLeft(20)),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }


  /*                                        ValueListenableBuilder(
                                          valueListenable: dropSelectedValues,
                                          builder: (context, _, __) {
                                            return DropdownButton(
                                                    isExpanded: true,
                                                    isDense: true,
                                                    underline: SizedBox(),
                                                    value: dropSelectedValues.value[index],
                                                    onChanged: (value) {
                                                      dropSelectedValues.value[index] = value!;
                                                      setState(() {});
                                                    },
                                                    dropdownColor: context.theme.colorScheme.surfaceTint,
                                                    style: context.theme.textTheme.bodyMedium!,
                                                    items: data.options.map((e) {
                                                      return DropdownMenuItem(value: e, child: Text(context.translete(e)));
                                                    }).toList())
                                                .wrapPaddingTop(20);
                                          },
                                        )
*/

  Widget buildDropdown(IconData icon, String title, List<NameDataEntity?>? dataList, ValueNotifier<int?> selectedIdNotifier) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DecoratedBox(
                decoration: BoxDecoration(border: Border.all(width: 2, color: context.theme.iconTheme.color!)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(icon, color: context.theme.textTheme.bodyMedium!.color),
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: DecoratedBox(
                  decoration: BoxDecoration(border: Border.all(width: 2, color: context.theme.iconTheme.color!)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(context.translete(title)),
                        ValueListenableBuilder<int?>(
                          valueListenable: selectedIdNotifier,
                          builder: (context, selectedId, _) {
                            return DropdownButton<int?>(
                              value: selectedId,
                              isExpanded: true,
                              isDense: true,
                              underline: SizedBox(),
                              dropdownColor: context.theme.colorScheme.surfaceTint,
                              style: context.theme.textTheme.bodyMedium!,
                              onChanged: (newId) {
                                selectedIdNotifier.value = newId;
                              },
                              items: dataList!.map((data) {
                                return DropdownMenuItem<int?>(
                                  value: data!.id,
                                  child: Text(languageControl(data.name!).toString()),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ).wrapPaddingBottom(20));
  }

  String? languageControl(NameTextEntity nameTextEntity){
    try{
      if(localeNotifier.value!.languageCode.compareTo("en") == 0){
        return nameTextEntity.en;
      }else{
        return nameTextEntity.tr;
      }
    }catch(e){

      return "null";
    }
  }
}
