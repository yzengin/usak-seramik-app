import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:usak_seramik_app/Controller/color_generator.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Controller/preferences.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import '/view/style/colors.dart';
import '/view/widget/utility/image_loading_builder.dart';
import 'model/onboard.dart';
import 'Controller/extension.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController pageController = PageController();
  ValueNotifier<PaletteGenerator?> palette = ValueNotifier<PaletteGenerator?>(null);

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      exceptedAction.value = true;
      updatePaletteGenerator(url: onboardList.first.image!).then((value) => palette.value = value).whenComplete(() {
      exceptedAction.value = false;
        setState(() {});
      });
    });
    preferenceHandler();
    super.initState();
  }

  Future preferenceHandler() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(AppPreferences.onboarding, false);
  }

  @override
  Widget build(BuildContext context) {
    return (palette.value == null)
        ? ColoredBox(color: context.theme.scaffoldBackgroundColor)
        : AnimatedContainer(
            duration: 300.millisecond(),
            color: palette.value!.colors.first.increaseLuminance(target: 0.65),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
              ),
              body: Column(
                children: [
                  Flexible(
                    flex: 7,
                    child: onboardingContent(context, pageController),
                  ),
                  Flexible(
                    flex: 1,
                    child: onboardingController(context, pageController),
                  )
                ],
              ),
            ),
          );
  }

  Widget onboardingContent(BuildContext context, PageController pageController) {
    return PageView.builder(
      controller: pageController,
      onPageChanged: (value) {},
      itemCount: onboardList.length,
      itemBuilder: (context, index) {
        final data = onboardList[index];
        return Padding(
          padding: EdgeInsets.only(
            top: context.paddingTop * 1,
            left: context.width * 0.05,
            right: context.width * 0.05,
          ),
          child: Column(
            children: [
              Flexible(
                flex: 4,
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: (index == 0) ? -0.25 : 0.25,
                      child: Center(
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 10,
                          color: palette.value!.colors.first,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Opacity(
                              opacity: 0,
                              child: Image.asset(
                                data.imageAsset!,
                                opacity: AlwaysStoppedAnimation(0.2),
                                fit: BoxFit.fitWidth,
                                errorBuilder: errorBuilder,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 10,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            data.image!,
                            fit: BoxFit.fitWidth,
                            loadingBuilder: loadingBuilder,
                            errorBuilder: errorBuilder,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText(
                              data.title!,
                              textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold, color: palette.value!.colors.first.increaseLuminance(target: 0.65).getContrastColor().toPastelColor().increaseLuminance(target: 0.3)),
                              textAlign: TextAlign.center,
                              speed: 50.millisecond(),
                            ),
                          ],
                          displayFullTextOnTap: true,
                          stopPauseOnTap: true,
                          isRepeatingAnimation: false,
                          repeatForever: false,
                        ),
                      ),
                      Text(
                        data.description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: palette.value!.colors.first.getContrastColor().toPastelColor()),
                      ).wrapPaddingTop(20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget onboardingController(BuildContext context, PageController pageController) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.paddingBottom,
        left: context.width * 0.05,
        right: context.width * 0.05,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmoothPageIndicator(
            controller: pageController,
            count: onboardList.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primaryColor,
              dotColor: AppColors.greyS6,
              dotHeight: 7,
            ),
            onDotClicked: (index) async {
              await updatePaletteGenerator(url: onboardList[index].image!).then((value) => palette.value = value).whenComplete(() {
                setState(() {});
              });
              pageController.animateToPage(index, duration: 300.millisecond(), curve: Curves.elasticOut);
            },
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await updatePaletteGenerator(url: onboardList[0].image!).then((value) => palette.value = value).whenComplete(() {
                    setState(() {});
                  });
                  pageController.previousPage(duration: 300.millisecond(), curve: Curves.ease);
                },
                padding: EdgeInsets.zero,
                icon: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  minRadius: 160,
                  child: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white, size: 20),
                ),
              ).wrapPaddingRight(10),
              IconButton(
                onPressed: () async {
                  if (pageController.page == onboardList.length - 1) {
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.auth_page, (route) => false);
                  }
                  await updatePaletteGenerator(url: onboardList[1].image!).then((value) => palette.value = value).whenComplete(() {
                    setState(() {});
                  });
                  pageController.nextPage(duration: 300.millisecond(), curve: Curves.ease);
                },
                padding: EdgeInsets.zero,
                icon: CircleAvatar(
                  backgroundColor: AppColors.primaryColor,
                  minRadius: 160,
                  child: const Icon(FontAwesomeIcons.chevronRight, color: Colors.white, size: 20),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
