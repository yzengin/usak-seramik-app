import 'package:flutter/material.dart';

class AppLanguage {
  String title;
  String icon;
  Locale locale;
  AppLanguage({
    required this.title,
    required this.icon,
    required this.locale,
  });
}

List<AppLanguage> languageList() => [
      AppLanguage(title: 'Türkçe', icon: "assets/flag/tr.png", locale: const Locale('tr', 'TR')),
      AppLanguage(title: 'English', icon: "assets/flag/en.png", locale: const Locale('en', 'US')),
      // AppLanguage(title: 'Deutsch', icon: "assets/flag/de.png", locale: const Locale('de', 'DE')),
      // AppLanguage(title: 'Français', icon: "assets/flag/fr.png", locale: const Locale('fr', 'FR')),
      // AppLanguage(title: 'Español', icon: "assets/flag/es.png", locale: const Locale('es', 'ES')),
      // AppLanguage(title: 'Português', icon: "assets/flag/pt.png", locale: const Locale('pt', 'PT')),
      // AppLanguage(title: 'русский', icon: "assets/flag/ru.png", locale: const Locale('ru', 'RU')),
      // AppLanguage(title: '中國人', icon: "assets/flag/zh.png", locale: const Locale('zh', 'ZH')),
      // AppLanguage(title: '日本語', icon: "assets/flag/ja.png", locale: const Locale('ja', 'JP')),
      // AppLanguage(title: 'עברית', icon: "assets/flag/he.png", locale: const Locale('he', 'IL')),
      // AppLanguage(title: 'Afrikaans', icon: "assets/flag/af.png", locale: const Locale('af', 'ZA')),
    ];
