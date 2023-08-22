import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Model/fake/product.dart';
import 'package:usak_seramik_app/View/custom/curves.dart';
import 'package:usak_seramik_app/View/style/colors.dart';

import '../../../view/page/mobile/main/homepage.dart';

class Showreel extends StatelessWidget {
  const Showreel({
    super.key,
    required this.autoPlayDuration,
    required this.autoPlayAnimationDuration,
  });

  final Duration autoPlayDuration;
  final Duration autoPlayAnimationDuration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FlutterCarousel.builder(
          options: CarouselOptions(
            height: context.height,
            showIndicator: false,
            slideIndicator: CircularWaveSlideIndicator(
              currentIndicatorColor: AppColors.secondaryColor,
              indicatorBackgroundColor: Colors.white,
              itemSpacing: 12,
              indicatorRadius: 5,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 0),
            ),
            indicatorMargin: 10,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            physics: const BouncingScrollPhysics(),
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            autoPlay: true,
            autoPlayInterval: autoPlayDuration,
            autoPlayAnimationDuration: autoPlayAnimationDuration,
            autoPlayCurve: AppCurves.smoothStep(),
          ),
          itemCount: showreelList.length,
          itemBuilder: (context, index, realIndex) {
            final data = showreelList[index];
            return Container(
              width: context.width,
              height: context.height,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(data.image), fit: BoxFit.fitHeight, opacity: 0.2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                // RotateAnimatedText(
                                //   data.name.toUpperCase(),
                                //   alignment: Alignment.centerLeft,
                                //   rotateOut: false,
                                //   textAlign: TextAlign.start,
                                //   transitionHeight: 100,
                                //   duration: autoPlayAnimationDuration,
                                //   textStyle: context.theme.textTheme.bodyMedium!.copyWith(fontSize: 45, letterSpacing: 3, fontWeight: FontWeight.w300),
                                // ),
                                TyperAnimatedText(
                                  data.title.toUpperCase(),
                                  textAlign: TextAlign.start,
                                  curve: AppCurves.flicker(),
                                  speed: Duration(milliseconds: autoPlayAnimationDuration.inMilliseconds ~/ (data.title.length)),
                                  textStyle: context.theme.textTheme.bodyMedium!.copyWith(fontSize: 45, letterSpacing: 3, fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AspectRatio(aspectRatio: 16 / 9, child: Material(elevation: 10, child: Image.network(data.image))),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(data.description, style: context.theme.textTheme.bodyMedium!.copyWith(fontSize: 19)),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40.0 + kToolbarHeight),
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, AppRoutes.product_detail_page, arguments: [data]);
                                },
                                style: ButtonStyle(maximumSize: MaterialStateProperty.all(Size.fromWidth(context.width * 0.4))),
                                child: Text(context.translete('show')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: GestureDetector(
              onTap: () => pageViewController.nextPage(duration: autoPlayAnimationDuration, curve: AppCurves.overshoot()),
              child: Row(children: [
                Animate(effects: [MoveEffect(duration: autoPlayAnimationDuration, delay: 100.milliseconds, begin: Offset(0, -5), end: Offset(0, 5))], onComplete: (controller) => controller.repeat(reverse: true), child: Icon(FontAwesomeIcons.chevronDown)).wrapPaddingHorizontal(10),
                Expanded(child: Text(context.translete('findProductButton')).wrapPaddingLeft(20)),
              ]),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: context.paddingTop * 1.1),
            child: Image.asset(
              AppImage.logotype,
              color: context.theme.textTheme.bodyMedium!.color,
              width: context.width * 0.4,
            ),
          ),
        )
      ],
    );
  }
}
