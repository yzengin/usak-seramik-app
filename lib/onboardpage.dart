import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '/view/style/colors.dart';
import '/view/widget/utility/image_loading_builder.dart';
import 'model/onboard.dart';
import 'Controller/extension.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();
    return Scaffold(
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
    );
  }

  Widget onboardingContent(BuildContext context, PageController pageController) {
    return PageView.builder(
      controller: pageController,
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
                child: SizedBox.expand(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      data.image!,
                      fit: BoxFit.fitWidth,
                      loadingBuilder: loadingBuilder,
                      errorBuilder: errorBuilder,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            data.title!,
                            textStyle: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                            speed: 50.millisecond(),
                          ),
                        ],
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                        isRepeatingAnimation: false,
                        repeatForever: false,
                      ),
                      Text(
                        data.description!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.black.withOpacity(.7)),
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
              dotColor: AppColors.greyS2,
              dotHeight: 7,
            ),
            onDotClicked: (index) => pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.elasticOut),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: IconButton(
                  onPressed: () {
                    pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
                  },
                  padding: EdgeInsets.zero,
                  icon: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    minRadius: 160,
                    child: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white, size: 20),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (pageController.page == onboardList.length - 1) {
                    Navigator.pushNamedAndRemoveUntil(context, 'auth_page', (route) => false);
                  }
                  pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
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
