// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Rest/Controller/Dealer/dealer_controller.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_controller.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/product_features_controller.dart';
import 'package:usak_seramik_app/Rest/Controller/Product/showreel_controller.dart';
import 'package:usak_seramik_app/Rest/Controller/User/contact_controller.dart';
import 'package:usak_seramik_app/View/style/colors.dart';
import '/Model/languages.dart';
import 'Controller/localization.dart';
import 'Controller/notification_helper.dart';
import 'Controller/theme.dart';
import '/model/data.dart';
import 'Controller/notifiers.dart';
import 'Controller/stopwatch.dart';
import 'Controller/routes.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() => run();

Future run() async {
  // ignore: unused_local_variable
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await LocalizationController().load();
  stopwatch.start(); // for a process timing analyz. use with stopwatchTick() method.
  try {
    if (GetPlatform.isMobile) {
      // ignore: unused_local_variable
      String? token = await FirebaseMessaging.instance.getAPNSToken();
      print('TOKENNN ####-- $token');
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);

    }
  } catch (e) {
    debugPrint('Error Main Data --- $e');
  }

  runApp(AppStarter(destination: AppRoutes.splash_page));
}

class AppStarter extends StatelessWidget {
  AppStarter({super.key, required this.destination});
  final GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final String destination;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeController()),
        ChangeNotifierProvider(create: (context) => LocalizationController()),
        ChangeNotifierProvider(create: (context) => DealerController()),
        ChangeNotifierProvider(create: (context) => ProductController()),
        ChangeNotifierProvider(create: (context) => ShowreelController()),
        ChangeNotifierProvider(create: (context) => ContactController()),
        ChangeNotifierProvider(create: (context) => ProductFeaturesController()),
      ],
      child: Consumer<LocalizationController>(builder: (context, _, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            MaterialApp(
              key: scaffoldKey,
              showPerformanceOverlay: false,
              routes: appRoutes(),
              initialRoute: destination,
              navigatorKey: navigatorKey,
              navigatorObservers: [PageTrackingObserver(context)],
              debugShowCheckedModeBanner: false,
              color: Colors.black,
              theme: Provider.of<ThemeController>(context).theme,
              locale: const Locale('tr', 'TR'),
              supportedLocales: languageList().map((e) => e.locale).toList(),
              localizationsDelegates: const [
                LocalizationController.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            ),
            ValueListenableBuilder(
              valueListenable: exceptedAction,
              builder: (context, value, child) {
                return Visibility(
                  visible: exceptedAction.value,
                  child: SizedBox.expand(
                    child: WillPopScope(
                      onWillPop: () async => exceptedAction.value,
                      child: ColoredBox(
                        color: Theme.of(context).textTheme.bodyMedium!.color!.withOpacity(.75),
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        );
      }),
    );
  }
}

class PageTrackingObserver extends NavigatorObserver {
  PageTrackingObserver(this.context);
  BuildContext context;
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    onRouteNotifier.value = DualData(route.settings.name.toString(), previousRoute != null ? previousRoute.settings.name.toString() : "null");
    if (route.settings.name == 'splash') {}
    debugPrint('on route: ${onRouteNotifier.value.primary}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    onRouteNotifier.value = DualData(previousRoute != null ? previousRoute.settings.name.toString() : "null", route.settings.name.toString());
    debugPrint('on route: ${onRouteNotifier.value.primary}');
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}
