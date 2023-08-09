import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/notifiers.dart';
import 'package:usak_seramik_app/Controller/preferences.dart';
import '/model/languages.dart';

import '../../../Controller/localization.dart';

class LanguageChangerButton extends StatefulWidget {
  const LanguageChangerButton({super.key, this.callback});
  final VoidCallback? callback;

  @override
  State<LanguageChangerButton> createState() => _LanguageChangerButtonState();
}

class _LanguageChangerButtonState extends State<LanguageChangerButton> {
  @override
  void initState() {
    super.initState();
    localeNotifier.value = languageList().first.locale;
    getLastLang().then((value) {
      setState(() {
        localeNotifier.value = Locale(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    localeNotifier.value = Provider.of<LocalizationController>(context, listen: true).locale ?? localeNotifier.value;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: languageList()
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () async {
                    Provider.of<LocalizationController>(context, listen: false).set(e.locale);
                    if (widget.callback != null) {
                      widget.callback!.call();
                    }
                  },
                  child: Opacity(
                    opacity: localeNotifier.value!.languageCode == e.locale.languageCode ? 1 : 0.25,
                    child: Image.asset(e.icon, width: 50),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Future<String> getLastLang() async {
    String? lang;
    await SharedPreferences.getInstance().then((prefs) {
      lang = prefs.getString(AppPreferences.language);
    });
    return lang ?? "";
  }
}
