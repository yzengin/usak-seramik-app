// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';

class LocalizationController extends ChangeNotifier {
  Locale? locale;

  // LocalizationController({this.locale = const Locale('tr', 'TR')});
  LocalizationController();

  static LocalizationController? of(BuildContext context) {
    return Localizations.of<LocalizationController>(context, LocalizationController);
  }

  static const LocalizationsDelegate<LocalizationController> delegate = _LocalizationControllerDelegate();

  late Map<String, String?> _localizedStrings;

  Future set(Locale locale) async {
    SharedPreferences.getInstance().then((value) {
      value.setString("lang", locale.languageCode);
      this.locale = locale;
      load();
      notifyListeners();
    });
  }

  Future<Locale> get() async {
    late Locale locale;
    await SharedPreferences.getInstance().then((value) {
      locale = Locale(value.getString("lang") ?? 'tr');
    });
    return locale;
  }

  Future<bool> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedLang = prefs.getString("lang");
    if (selectedLang == null) {
      // Eğer seçili dil yoksa 'tr' olarak ayarla
      selectedLang = 'tr';
      localeNotifier.value = Locale('tr');
    } else {
      localeNotifier.value = Locale(selectedLang);
    }

    // Seçili dili kullanarak varsayılan yereli ayarla
    locale = Locale(selectedLang);

    String otherLangCode = selectedLang == "tr" ? "en" : "tr";

    String jsonString = await rootBundle.loadString('i18n/$selectedLang.json');
    String jsonStringOther = await rootBundle.loadString('i18n/$otherLangCode.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    Map<String, dynamic> jsonMapOther = json.decode(jsonStringOther);

    _localizedStrings = Map<String, String>.from(jsonMap);

    for (var key in jsonMapOther.keys) {
      if (!_localizedStrings.containsKey(key)) {
        _localizedStrings[key] = jsonMapOther[key].toString();
      }
    }

    notifyListeners();
    return true;
  }

  // Future<bool> load() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   // locale = Locale(locale.languageCode == "tr" ? "tr" : "en", locale.languageCode == "tr" ? "tr" : "en");
  //   String? lang;
  //   if (prefs.containsKey("lang")) {
  //     lang = prefs.getString("lang");
  //     locale = Locale(prefs.getString("lang")!, prefs.getString("lang"));
  //   } else {
  //     lang = 'tr';
  //     locale = Locale('tr', 'tr');
  //   }
  //   var currentLangCode = lang ?? locale.languageCode;
  //   var otherLangCode = currentLangCode == "tr" ? "en" : "tr";

  //   String jsonString = await rootBundle.loadString('i18n/$currentLangCode.json');
  //   String jsonStringOther = await rootBundle.loadString('i18n/$otherLangCode.json');
  //   Map<String, dynamic> jsonMap = json.decode(jsonString);
  //   Map<String, dynamic> jsonMapOther = json.decode(jsonStringOther);

  //   _localizedStrings = jsonMap.map((key, value) {
  //     return MapEntry(key, value.toString());
  //   });

  //   for (var key in jsonMapOther.keys) {
  //     if (!_localizedStrings.containsKey(key)) {
  //       _localizedStrings[key] = jsonMapOther[key];
  //     }
  //   }
  //   notifyListeners();
  //   return true;
  // }

  String? translate(String? key) {
    notifyListeners();
    return _localizedStrings[key!];
  }
}

class _LocalizationControllerDelegate extends LocalizationsDelegate<LocalizationController> {
  const _LocalizationControllerDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<LocalizationController> load(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("lang")) {
      locale = Locale(prefs.getString("lang")!, prefs.getString("lang"));
    }
    // LocalizationController class is where the JSON loading actually runs
    // LocalizationController localizations = LocalizationController(locale: locale);
    LocalizationController localizations = LocalizationController();
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_LocalizationControllerDelegate old) => true;
}

String? languageConverter(BuildContext context, String? nameParam) {
  return LocalizationController.of(context)!.translate(nameParam);
}
