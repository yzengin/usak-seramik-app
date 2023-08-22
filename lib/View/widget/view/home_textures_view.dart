import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/extension.dart';

import '../../../Controller/routes.dart';
import '../../../view/page/mobile/main/homepage.dart';
import '../../custom/curves.dart';
import 'coverflow.dart';

class ProductTexturesView extends StatefulWidget {
  const ProductTexturesView({super.key});

  @override
  State<ProductTexturesView> createState() => _ProductTexturesViewState();
}

class _ProductTexturesViewState extends State<ProductTexturesView> {
  ValueNotifier<int> carouselIndex = ValueNotifier<int>(2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.only(top: context.paddingTop * 1.5, bottom: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => pageViewController.previousPage(duration: autoPlayAnimationDuration, curve: AppCurves.overshoot()),
              child: Row(children: [
                Animate(effects: [MoveEffect(duration: autoPlayAnimationDuration, delay: 100.milliseconds, begin: Offset(0, -5), end: Offset(0, 5))], onComplete: (controller) => controller.repeat(reverse: true), child: Icon(FontAwesomeIcons.chevronUp)).wrapPaddingHorizontal(10),
                Expanded(child: Text(context.translete('findProductButton')).wrapPaddingLeft(20)),
              ]).wrapPaddingHorizontal(20),
            ),
            Expanded(
              child: ValueListenableBuilder(
                  valueListenable: carouselIndex,
                  builder: (context, _, __) {
                    return CoverFlow(
                      onCenterItemSelected: (i){
                        debugPrint('${i}');
                        Navigator.pushNamed(context, AppRoutes.search_result_page);
                      },
                      titles: textures.map((e) => context.translete('search')).toList(),
                      textStyle: context.textStyle,
                      displayOnlyCenterTitle: true,
                      images: textures.map((e) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, AppRoutes.search_result_page);
                          },
                          child: Column(
                            children: [
                              FittedBox(child: Text(context.translete(e.title))),
                              SizedBox(
                                height: context.height * 0.5,
                                child: Card(
                                  child: ClipRRect(borderRadius: BorderRadius.circular(kToolbarHeight * 0.2), child: Image.network(e.image, fit: BoxFit.fitHeight)),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class TexturesModel {
  late int id;
  late String title;
  late String image;
  TexturesModel({
    required this.id,
    required this.title,
    required this.image,
  });
}

List<TexturesModel> textures = [
  TexturesModel(id: 0, title: "wood", image: "https://www.usakseramik.com/img/textures/wood.jpg"),
  TexturesModel(id: 1, title: "marble", image: "https://www.usakseramik.com/img/textures/marble.jpg"),
  TexturesModel(id: 2, title: "stone", image: "https://www.usakseramik.com/img/textures/stone.jpg"),
  TexturesModel(id: 3, title: "decor", image: "https://www.usakseramik.com/img/textures/dekor.jpg"),
  TexturesModel(id: 4, title: "concrete", image: "https://www.usakseramik.com/img/textures/beton.jpg"),
];
