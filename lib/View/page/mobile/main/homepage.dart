import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/asset.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/Model/fake/product.dart';
import 'package:usak_seramik_app/View/custom/curves.dart';
import 'package:usak_seramik_app/View/style/colors.dart';

PageController pageViewController = PageController();
final Duration autoPlayDuration = 5.second();
final Duration autoPlayAnimationDuration = 700.millisecond();
List<Widget> pageItems = [
  Showreel(autoPlayDuration: autoPlayDuration, autoPlayAnimationDuration: autoPlayAnimationDuration),
  FindProductView(),
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return PageView.builder(
      controller: pageViewController,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 2,
      itemBuilder: (context, index) => pageItems[index],
    );
    // return Showreel(autoPlayDuration: autoPlayDuration, autoPlayAnimationDuration: autoPlayAnimationDuration);
    // items: productList.map((data) {
    //   return Builder(
    //     builder: (BuildContext context) {
    //       return Container(
    //         width: context.width,
    //         height: context.height,
    //         margin: EdgeInsets.zero,
    //         padding: EdgeInsets.zero,
    //         decoration: BoxDecoration(image: DecorationImage(image: AssetImage(data.image), fit: BoxFit.fitHeight, opacity: 0.5)),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const SizedBox(height: 200),
    //             Image.asset(data.image),
    //             SizedBox(
    //               height: 200,
    //               child: AnimatedTextKit(
    //                 isRepeatingAnimation: false,
    //                 totalRepeatCount: 1,
    //                 animatedTexts: [
    //                   RotateAnimatedText(
    //                     data.name.toLowerCase(),
    //                     duration: autoPlayDuration,
    //                     textStyle: context.theme.textTheme.bodyMedium!.copyWith(
    //                       fontSize: 33,
    //                       fontFamily: AppFont.raptor,
    //                     ),
    //                   ),
    //                 ],
    //                 // style: TextStyle(fontSize: 16.0),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //   );
    // }).toList());
  }
}

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
          itemCount: productList.length,
          itemBuilder: (context, index, realIndex) {
            final data = productList[index];
            return Container(
              width: context.width,
              height: context.height,
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(data.image), fit: BoxFit.fitHeight, opacity: 0.2)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 100,
                          width: context.width,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: AnimatedTextKit(
                                isRepeatingAnimation: false,
                                totalRepeatCount: 1,
                                animatedTexts: [
                                  RotateAnimatedText(
                                    data.name.toUpperCase(),
                                    alignment: Alignment.centerLeft,
                                    rotateOut: false,
                                    textAlign: TextAlign.start,
                                    transitionHeight: 200,
                                    duration: autoPlayAnimationDuration,
                                    textStyle: context.theme.textTheme.bodyMedium!.copyWith(fontSize: 45, letterSpacing: 3, fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: AspectRatio(aspectRatio: 16 / 9, child: Material(elevation: 10, child: Image.asset(data.image))),
                  ),
                  Expanded(
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
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20.0),
                            child: SizedBox(
                              height: kToolbarHeight,
                              child: ElevatedButton(
                                onPressed: () {},
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
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20.0),
            child: SizedBox(
              height: kToolbarHeight,
              child: IconButton(
                onPressed: () => pageViewController.animateToPage(1, duration: autoPlayAnimationDuration, curve: AppCurves.smoothStep()),
                icon: Icon(
                  FontAwesomeIcons.chevronDown,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FindProductView extends StatelessWidget {
  FindProductView({super.key});
  final ScrollController scrollController = ScrollController();
  final FocusNode usageAreaFocusNode = FocusNode();
  final FocusNode prodTypeFocusNode = FocusNode();
  final FocusNode prodTextureFocusNode = FocusNode();
  final FocusNode prodColorFocusNode = FocusNode();
  final FocusNode rawFocusNode = FocusNode();
  final TextEditingController usageAreaController = TextEditingController();
  final TextEditingController prodTypeController = TextEditingController();
  final TextEditingController prodTextureController = TextEditingController();
  final TextEditingController prodColorController = TextEditingController();
  final ValueNotifier<int> showIndex = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SizedBox.expand(
        child: Padding(
          padding: EdgeInsets.only(top: context.paddingTop * 1.5, left: 20, right: 20),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    child: IconButton(
                      onPressed: () => pageViewController.animateToPage(0, duration: autoPlayAnimationDuration, curve: AppCurves.smoothStep()),
                      icon: Icon(
                        FontAwesomeIcons.chevronUp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(context.translete('findProductTitle'), style: context.theme.textTheme.bodyMedium!.copyWith(fontSize: 16)),
                          Text(context.translete('findProductDescription'), style: context.theme.textTheme.bodyMedium!.copyWith(fontSize: 13, color: context.theme.textTheme.bodyMedium!.color!.withOpacity(.5))),
                        ],
                      ),
                    ).wrapPaddingLeft(20),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 40, bottom: 100),
                  controller: scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          AppIcon.usageArea,
                          color: context.theme.textTheme.bodyMedium!.color,
                          width: 40,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.translete('kullanimAlani')),
                              Focus(
                                focusNode: usageAreaFocusNode,
                                onFocusChange: (value) {
                                  if (value) {
                                    showIndex.value = 0;
                                  } else {
                                    showIndex.value = -1;
                                  }
                                },
                                child: DropdownMenu(
                                  controller: usageAreaController,
                                  width: context.width - 100,
                                  menuHeight: 200,
                                  enableFilter: true,
                                  enableSearch: true,
                                  onSelected: (value) => FocusScope.of(context).unfocus(),
                                  hintText: context.translete('select'),
                                  dropdownMenuEntries: [
                                    context.translete('yasamAlani'),
                                    context.translete('mutfak'),
                                    context.translete('banyo'),
                                    context.translete('disMekan'),
                                  ].map((e) {
                                    return DropdownMenuEntry(value: e, label: e);
                                  }).toList(),
                                  // DropdownMenuEntry(
                                  //   value: 0,
                                  //   label: 'label',
                                  //   style: ButtonStyle(textStyle: MaterialStateProperty.all(context.theme.textTheme.bodyMedium!), backgroundColor: MaterialStateProperty.all(context.theme.scaffoldBackgroundColor)),
                                  // ),
                                ),
                              ).wrapPaddingTop(20),
                            ],
                          ),
                        ))
                      ],
                    ).wrapPaddingBottom(20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppIcon.prodType,
                          color: context.theme.textTheme.bodyMedium!.color,
                          width: 40,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.translete('urunTuru')),
                              Focus(
                                focusNode: prodTypeFocusNode,
                                onFocusChange: (value) {
                                  if (value) {
                                    showIndex.value = 1;
                                  } else {
                                    showIndex.value = -1;
                                  }
                                },
                                child: DropdownMenu(
                                  controller: prodTypeController,
                                  width: context.width - 100,
                                  menuHeight: 200,
                                  enableFilter: true,
                                  enableSearch: true,
                                  onSelected: (value) => FocusScope.of(context).unfocus(),
                                  hintText: context.translete('select'),
                                  dropdownMenuEntries: [
                                    context.translete('tezgahArasi'),
                                    context.translete('takimUrunler'),
                                    context.translete('yerUrunler'),
                                    context.translete('granitler'),
                                    context.translete('disMekanSerileri'),
                                    context.translete('parkeUrunleri'),
                                    context.translete('havuzUrunleri'),
                                  ].map((e) {
                                    return DropdownMenuEntry(value: e, label: e);
                                  }).toList(),
                                  // DropdownMenuEntry(
                                  //   value: 0,
                                  //   label: 'label',
                                  //   style: ButtonStyle(textStyle: MaterialStateProperty.all(context.theme.textTheme.bodyMedium!), backgroundColor: MaterialStateProperty.all(context.theme.scaffoldBackgroundColor)),
                                  // ),
                                ),
                              ).wrapPaddingTop(20),
                            ],
                          ),
                        ))
                      ],
                    ).wrapPaddingBottom(20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Image.asset(
                          AppIcon.prodTexture,
                          color: context.theme.textTheme.bodyMedium!.color,
                          width: 40,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.translete('urunDokusu')),
                              Focus(
                                focusNode: prodTextureFocusNode,
                                onFocusChange: (value) {
                                  if (value) {
                                    showIndex.value = 2;
                                  } else {
                                    showIndex.value = -1;
                                  }
                                },
                                child: DropdownMenu(
                                  controller: prodTextureController,
                                  width: context.width - 100,
                                  menuHeight: 200,
                                  enableFilter: true,
                                  enableSearch: true,
                                  onSelected: (value) => FocusScope.of(context).unfocus(),
                                  hintText: context.translete('select'),
                                  dropdownMenuEntries: [
                                    context.translete('kombin'),
                                    context.translete('beton'),
                                    context.translete('mermer'),
                                    context.translete('tas'),
                                    context.translete('ahsapMermer'),
                                    context.translete('ahsap'),
                                  ].map((e) {
                                    return DropdownMenuEntry(value: e, label: e);
                                  }).toList(),
                                  // DropdownMenuEntry(
                                  //   value: 0,
                                  //   label: 'label',
                                  //   style: ButtonStyle(textStyle: MaterialStateProperty.all(context.theme.textTheme.bodyMedium!), backgroundColor: MaterialStateProperty.all(context.theme.scaffoldBackgroundColor)),
                                  // ),
                                ),
                              ).wrapPaddingTop(20),
                            ],
                          ),
                        ))
                      ],
                    ).wrapPaddingBottom(20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          AppIcon.prodColor,
                          color: context.theme.textTheme.bodyMedium!.color,
                          width: 40,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(context.translete('urunRengi')),
                              Focus(
                                focusNode: prodColorFocusNode,
                                onFocusChange: (value) {
                                  if (value) {
                                    showIndex.value = 3;
                                  } else {
                                    showIndex.value = -1;
                                  }
                                },
                                child: DropdownMenu(
                                  controller: prodColorController,
                                  width: context.width - 100,
                                  menuHeight: 200,
                                  enableFilter: true,
                                  enableSearch: true,
                                  onSelected: (value) => FocusScope.of(context).unfocus(),
                                  hintText: context.translete('select'),
                                  dropdownMenuEntries: [
                                    context.translete('antrasit'),
                                    context.translete('bej'),
                                    context.translete('siyah'),
                                    context.translete('mavi'),
                                    context.translete('bone'),
                                    context.translete('kahve'),
                                    context.translete('dekor'),
                                    context.translete('ekru'),
                                    context.translete('gri'),
                                    context.translete('kirmizi'),
                                    context.translete('beyaz'),
                                  ].map((e) {
                                    return DropdownMenuEntry(value: e, label: e);
                                  }).toList(),
                                  // DropdownMenuEntry(
                                  //   value: 0,
                                  //   label: 'label',
                                  //   style: ButtonStyle(textStyle: MaterialStateProperty.all(context.theme.textTheme.bodyMedium!), backgroundColor: MaterialStateProperty.all(context.theme.scaffoldBackgroundColor)),
                                  // ),
                                ),
                              ).wrapPaddingTop(20),
                            ],
                          ),
                        ))
                      ],
                    ).wrapPaddingBottom(20),
                    Padding(
                      padding: const EdgeInsets.only(left: 60.0),
                      child: ElevatedButton(onPressed: () {}, child: Text(context.translete('find'))),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
