import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/routes.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_features_controller.dart';
import 'Controller/asset.dart';
import 'Controller/extension.dart';
import '/view/style/colors.dart';
import 'Controller/preferences.dart';
import 'Controller/theme.dart';
import 'Controller/timer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late final AppTimer timer;

  

  @override
  void initState() {
    themeInitialize();
    timer = AppTimer(
        countdowntimer: true,
        countdowntime: 2,
        countdownCallback: () async {
          // await AppPreferencesHandler.getBool(AppPreferences.onboarding).then((value) {
          //   debugPrint('1 $value');
          //   if (value != null) {
          //     if (value == false) {
          //       AppPreferencesHandler.setBool(AppPreferences.onboarding, true);
          //       Navigator.pushNamedAndRemoveUntil(context, AppRoutes.onboarding_page, (route) => false);
          //       AppPreferencesHandler.getBool(AppPreferences.onboarding).then((value) => debugPrint('2 $value'));
          //     } else {
          //       Navigator.pushNamedAndRemoveUntil(context, AppRoutes.auth_page, (route) => false);
          //     }
          //   } else {
          //     Navigator.pushNamedAndRemoveUntil(context, AppRoutes.onboarding_page, (route) => false).whenComplete(() {
          //       AppPreferencesHandler.setBool(AppPreferences.onboarding, true);
          //     });
          //   }
          // });
          SharedPreferences preferences = await SharedPreferences.getInstance();
          bool? showFirst = preferences.getBool(AppPreferences.onboarding);
          if (showFirst == null || showFirst == true) {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.onboarding_page, (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.auth_page, (route) => false);
          //   Navigator.pushNamedAndRemoveUntil(context, AppRoutes.mainpageview, (route) => false);
          }
        });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timer.start();
      Provider.of<ProductFeaturesController>(context, listen: false).getColorController();
      Provider.of<ProductFeaturesController>(context, listen: false).getGlossController();
      Provider.of<ProductFeaturesController>(context, listen: false).getSizeController();
      Provider.of<ProductFeaturesController>(context, listen: false).getSurfaceController();
      Provider.of<ProductFeaturesController>(context, listen: false).getTypeController();
      Provider.of<ProductFeaturesController>(context, listen: false).getUsageAreaController();
    });
  }

  themeInitialize() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey(AppPreferences.themeIsDark)) {
      Provider.of<ThemeController>(context, listen: false).themeChanger(value: preferences.getBool(AppPreferences.themeIsDark));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Animate(
              effects: [FadeEffect(duration: 500.milliseconds, delay: 500.milliseconds, begin: 1, end: 0), TintEffect(duration: 500.milliseconds, delay: 100.milliseconds, color: context.theme.textTheme.bodyMedium!.color)],
              child: Image.asset(AppImage.logotype, color: AppColors.secondaryColor).wrapPaddingAll(50),
              onPlay: (controller) => controller.repeat(reverse: true),
            ),
          ],
        ),
      ),
    );
  }
}
