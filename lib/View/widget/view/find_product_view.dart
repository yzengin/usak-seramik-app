import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/View/custom/curves.dart';

import '../../../view/page/mobile/main/homepage.dart';

class FindProductView extends StatefulWidget {
  FindProductView({super.key});

  @override
  State<FindProductView> createState() => _FindProductViewState();
}

class _FindProductViewState extends State<FindProductView> {
  final ScrollController scrollController = ScrollController();
  final PageController findProductPageController = PageController();
  final ValueNotifier<int> showIndex = ValueNotifier<int>(-1);
  ValueNotifier<List<String>> dropSelectedValues = ValueNotifier(List.generate(findProductList().length, (index) => 'all'));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    dropSelectedValues.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 20),
                  itemCount: findProductList().length,
                  itemBuilder: (context, index) {
                    final data = findProductList()[index];
                    return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DecoratedBox(
                                decoration: BoxDecoration(border: Border.all(width: 2, color: Colors.white)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(data.icon, color: context.theme.textTheme.bodyMedium!.color),
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
                                        Text(context.translete(data.title)),
                                        ValueListenableBuilder(
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
                                                    style: context.theme.textTheme.bodyMedium!.copyWith(color: Colors.white),
                                                    items: data.options.map((e) {
                                                      return DropdownMenuItem(value: e, child: Text(context.translete(e)));
                                                    }).toList())
                                                .wrapPaddingTop(20);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ).wrapPaddingBottom(20));
                  },
                ),
              ),
              ElevatedButton(
                      onPressed: () {
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
}

class FindProductModel {
  late int id;
  late String title;
  late IconData icon;
  late List<String> options;
  FindProductModel({required this.id, required this.title, required this.icon, required this.options});
}

List<FindProductModel> findProductList() => [
      FindProductModel(
        id: 0,
        title: 'kullanimAlani',
        icon: FontAwesomeIcons.personShelter,
        options: [
          'all',
          'yasamAlani',
          'mutfak',
          'banyo',
          'disMekan',
        ],
      ),
      FindProductModel(
        id: 1,
        title: 'urunTuru',
        icon: FontAwesomeIcons.layerGroup,
        options: [
          'all',
          'tezgahArasi',
          'takimUrunler',
          'yerUrunler',
          'granitler',
          'disMekanSerileri',
          'parkeUrunleri',
          'havuzUrunleri',
        ],
      ),
      FindProductModel(
        id: 2,
        title: 'urunDokusu',
        icon: FontAwesomeIcons.swatchbook,
        options: [
          'all',
          'decor',
          'concrete',
          'marble',
          'stone',
          'ahsapMermer',
          'wood',
        ],
      ),
      FindProductModel(
        id: 3,
        title: 'urunRengi',
        icon: FontAwesomeIcons.palette,
        options: [
          'all',
          'antrasit',
          'bej',
          'siyah',
          'mavi',
          'bone',
          'kahve',
          'dekor',
          'ekru',
          'gri',
          'kirmizi',
          'beyaz',
        ],
      ),
    ];
