// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:usak_seramik_app/Controller/extension.dart';
import 'package:usak_seramik_app/View/page/mobile/detail/favourites_page.dart';
import 'package:usak_seramik_app/View/page/mobile/detail/product_detail_page.dart';
import 'package:usak_seramik_app/View/page/mobile/main/contactpage.dart';
import 'package:usak_seramik_app/View/page/mobile/main/pruductspage.dart';
import 'package:usak_seramik_app/View/page/mobile/main/salespointpage.dart';
import '../View/page/mobile/detail/search_result_page.dart';
import '/main.dart';
import '/view/page/mobile/main/mainpage.dart';
import '../onboardpage.dart';
import '/view/page/auth/auth.dart';
import '/view/page/mobile/main/homepage.dart';

import '../splashpage.dart';

Map<String, Widget Function(BuildContext)> appRoutes() => {
      AppRoutes.app_starter: (context) => AppStarter(destination: AppRoutes.splash_page),
      AppRoutes.splash_page: (context) => const SplashPage(),
      AppRoutes.onboarding_page: (context) => const OnboardingPage(),
      AppRoutes.auth_page: (context) => const AuthSwitcher(),
      AppRoutes.mainpageview: (context) => const MainPageView(),
      AppRoutes.home_page: (context) => const HomePage(),
      AppRoutes.products_page: (context) => const ProductsPage(),
      AppRoutes.product_detail_page: (context) => const ProductDetailPage(),
      AppRoutes.favourites_page: (context) => const FavouritesPage(),
      AppRoutes.salespoints_page: (context) => const SalesPointsPage(),
      AppRoutes.contact_page: (context) => const ContactPage(),
      AppRoutes.search_result_page: (context) => const SearchResultPage(),
    };

class AppRoutes {
  static String app_starter = "app_starter";
  static String splash_page = "splash_page";
  static String onboarding_page = "onboarding_page";
  static String auth_page = "auth_page";
  static String mainpageview = "mainpageview";
  static String home_page = "home_page";
  static String products_page = "products_page";
  static String product_detail_page = "product_detail_page";
  static String favourites_page = "favourites_page";
  static String salespoints_page = "salespoints_page";
  static String contact_page = "contact_page";
  static String search_result_page = "search_result_page";
}

List<Widget> mainPageList = [
  const HomePage(),
  const ProductsPage(),
  const SalesPointsPage(),
  const ContactPage(),
];

List<BottomNavigationBarItem> mainNavBarItemList(BuildContext context) => [
      BottomNavigationBarItem(icon: const Icon(FontAwesomeIcons.house), label: context.translete('home')),
      BottomNavigationBarItem(icon: const Icon(FontAwesomeIcons.layerGroup), label: context.translete('products')),
      BottomNavigationBarItem(icon: const Icon(FontAwesomeIcons.locationDot), label: context.translete('stores')),
      BottomNavigationBarItem(icon: const Icon(FontAwesomeIcons.headset), label: context.translete('contact')),
      // BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.user), label: 'Profile'),
    ];
