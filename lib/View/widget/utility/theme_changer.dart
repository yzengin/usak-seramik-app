import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:usak_seramik_app/Controller/extension.dart';

import '../../../Controller/theme.dart';

class ThemeChangerButton extends StatelessWidget {
  const ThemeChangerButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = Provider.of<ThemeController>(context, listen: true).isDark;

    return Row(mainAxisSize: MainAxisSize.min, children: [
      GestureDetector(
        onTap: () async => Provider.of<ThemeController>(context, listen: false).themeChanger(value: !isDark),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.solidMoon, color: context.theme.colorScheme.background, size: 30),
            // Text("${context.translete('darkTheme')} ${isDark ? 'Açık' : 'Kapalı'}", style: context.theme.textTheme.bodyMedium!.copyWith(color: isDark ? AppColors.greyS1 : AppColors.greyS3)).wrapPaddingLeft(10)
          ],
        ),
      ),
    ]);
  }
}
