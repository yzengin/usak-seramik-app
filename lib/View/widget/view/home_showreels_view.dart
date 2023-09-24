import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/showreel_controller.dart';
import 'package:usak_seramik_app/Rest/Entity/Product/showreel_entity.dart';
import 'package:usak_seramik_app/View/custom/curves.dart';
import 'package:usak_seramik_app/View/style/colors.dart';

import '../../../view/page/mobile/main/homepage.dart';
import '../drawer/contact_drawer.dart';

class Showreel extends StatefulWidget {
  Showreel({
    super.key,
    required this.autoPlayDuration,
    required this.autoPlayAnimationDuration,
  });

  final Duration autoPlayDuration;
  final Duration autoPlayAnimationDuration;

  @override
  State<Showreel> createState() => _ShowreelState();
}

class _ShowreelState extends State<Showreel> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  ShowreelData? showreelData;

  @override
  void initState() {
    super.initState();
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<ShowreelController>(context, listen: false).getShowreelController().then((value) {
          setState(() {});
        });
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    showreelData = Provider.of<ShowreelController>(context, listen: true).showreelData;
    return (showreelData == null)
        ? SizedBox()
        : (showreelData!.data == null)
            ? SizedBox()
            : Scaffold(
                key: scaffoldState,
                drawer: ContactDrawer(),
                body: Stack(
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
                        autoPlayInterval: widget.autoPlayDuration,
                        autoPlayAnimationDuration: widget.autoPlayAnimationDuration,
                        autoPlayCurve: AppCurves.smoothStep(),
                      ),
                      itemCount: showreelData!.data!.length,
                      itemBuilder: (context, index, realIndex) {
                        final data = showreelData!.data![index];
                        return Container(
                          width: context.width,
                          height: context.height,
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(data.images!.trImage!),
                            fit: BoxFit.fitHeight,
                            opacity: 0.2,
                          )),
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
                                            TyperAnimatedText(
                                              translateData(data.title!),
                                              textAlign: TextAlign.start,
                                              curve: AppCurves.flicker(),
                                              speed: Duration(milliseconds: widget.autoPlayAnimationDuration.inMilliseconds ~/ (translateData(data.title!).length)),
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
                                child: AspectRatio(aspectRatio: 16 / 9, child: Material(elevation: 10, child: Image.network(translateImage(data.images!)))),
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
                                        child: Text(translateData(data.content!), style: context.theme.textTheme.bodyMedium!.copyWith(fontSize: 19)),
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
                                              Navigator.pushNamed(context, AppRoutes.product_detail_page, arguments: [data.productId, null]);
                                            },
                                            style: ButtonStyle(maximumSize: MaterialStateProperty.all(Size.fromWidth(context.width * 0.4))),
                                            // child: Text(context.translete('show')),
                                            child: Text(translateData(data.linktext!).firstLetterUpperCase(), style: context.textStyle.copyWith(fontSize: 12, color: Colors.white), textAlign: TextAlign.center),
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
                          onTap: () => pageViewController.nextPage(duration: widget.autoPlayAnimationDuration, curve: AppCurves.overshoot()),
                          child: Row(children: [
                            Animate(effects: [MoveEffect(duration: widget.autoPlayAnimationDuration, delay: 100.milliseconds, begin: Offset(0, -5), end: Offset(0, 5))], onComplete: (controller) => controller.repeat(reverse: true), child: Icon(FontAwesomeIcons.chevronDown)).wrapPaddingHorizontal(10),
                            Expanded(child: Text(context.translete('findProductButton')).wrapPaddingLeft(20)),
                          ]),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: context.paddingTop * 1.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(onPressed: () => scaffoldState.currentState!.openDrawer(), icon: Icon(FontAwesomeIcons.bars, color: context.theme.colorScheme.surface)),
                            Image.asset(
                              AppImage.logotype,
                              color: context.theme.textTheme.bodyMedium!.color,
                              width: context.width * 0.4,
                            ),
                            Opacity(opacity: 0, child: IconButton(onPressed: () => scaffoldState.currentState!.openDrawer(), icon: Icon(FontAwesomeIcons.bars, color: context.theme.colorScheme.surface))),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
  }
}
