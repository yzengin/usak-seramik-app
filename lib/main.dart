// ignore_for_file: unnecessary_overrides

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '/Model/languages.dart';
import 'Controller/localization.dart';
import 'Controller/theme.dart';
import '/model/data.dart';
import 'Controller/notifiers.dart';
import 'Controller/stopwatch.dart';
import 'Controller/routes.dart';

void main() => run();

Future run() async {
  // ignore: unused_local_variable
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await LocalizationController().load();
  stopwatch.start(); // for a process timing analyz. use with stopwatchTick() method.
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
        ChangeNotifierProvider(create: (context2) => ThemeController()),
        ChangeNotifierProvider(create: (context2) => LocalizationController()),
      ],
      child: Consumer<LocalizationController>(builder: (context, _, __) {
        return Stack(
          alignment: Alignment.center,
          children: [
            MaterialApp(
              key: scaffoldKey,
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
                        child: const Center(
                          child: CircularProgressIndicator(),
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
