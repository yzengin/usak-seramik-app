import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usak_seramik_app/Controller/preferences.dart';
import '/view/style/colors.dart';
import 'asset.dart';

class ThemeController extends ChangeNotifier {
  ThemeData _theme() => isDark ? appThemeDark() : appThemeLight();
  bool isDark = false;
  ThemeData get theme => _theme();
  themeChanger({bool? value}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (value != null) {
      isDark = value;
      preferences.setBool(AppPreferences.themeIsDark, value);
    } else {
      isDark = !isDark;
      preferences.setBool(AppPreferences.themeIsDark, isDark);
    }
    notifyListeners();
  }
}

// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ LIGHT
ThemeData appThemeLight() => ThemeData(
      // ----------------------------------- COLOR
      colorScheme: const ColorScheme.light().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        tertiary: AppColors.redS4,
        surface: AppColors.secondaryColor,
        surfaceTint: AppColors.greyS4,
        background: AppColors.greyS3,
        onBackground: AppColors.greyS1,
        shadow: AppColors.greyS1,
        brightness: Brightness.dark,
      ),
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      dividerColor: AppColors.greyS6,
      // ----------------------------------- TEXT
      fontFamily: AppFont.avenir,
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyMedium: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
      // ----------------------------------- DECORATION
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(.25),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(.25),
            width: 3,
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      // ----------------------------------- WIDGET
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.greyS1,
        foregroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.black),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(kToolbarHeight * 0),
          ),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: Colors.white,
        elevation: 0,
        scrimColor: AppColors.greyS2.withOpacity(.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(0))),
      ),
      cardTheme: CardTheme(
        color: AppColors.greyS1,
        elevation: 0,
        shadowColor: AppColors.greyS1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kToolbarHeight * 0.2),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.greyS1,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: AppColors.secondaryColor),
        unselectedIconTheme: IconThemeData(color: AppColors.greyS3),
        selectedItemColor: AppColors.secondaryColor,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedItemColor: AppColors.greyS3,
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(AppColors.primaryColor),
        visualDensity: VisualDensity.standard,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      // ----------------------------------- DIALOG & SHEET
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
        circularTrackColor: AppColors.primaryColor.withOpacity(.25),
        linearTrackColor: AppColors.primaryColor.withOpacity(.25),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.greyS1,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        actionsPadding: EdgeInsets.zero,
        contentTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        backgroundColor: AppColors.greyS1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(kToolbarHeight * 0.5),
          ),
        ),
      ),
      // ----------------------------------- BUTTON
      iconButtonTheme: const IconButtonThemeData(),
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
          foregroundColor: MaterialStateProperty.all(Colors.white)
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          iconColor: Colors.black,
          fillColor: Colors.black,
          focusColor: Colors.black,
          hoverColor: Colors.black,
          prefixIconColor: Colors.black,
          suffixIconColor: Colors.black,
        ),
        menuStyle: MenuStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          side: MaterialStateProperty.all(BorderSide.none),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.greyS3,
        focusColor: AppColors.purpleS1,
        hoverColor: AppColors.redS1,
        elevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          // shape: MaterialStateProperty.all(ContinuousRectangleBorder(
          //   borderRadius: BorderRadius.circular(kToolbarHeight * 0.5),
          // )),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          fixedSize: MaterialStateProperty.all(const Size(1000, kToolbarHeight)),
          splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
          backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return appThemeDark().colorScheme.primary;
            } else {
              return Colors.white;
            }
          }),
        ),
      ),
    );
// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ DARK
ThemeData appThemeDark() => ThemeData(
      // ----------------------------------- COLOR
      colorScheme: const ColorScheme.dark().copyWith(
        primary: AppColors.primaryColor,
        secondary: AppColors.secondaryColor,
        tertiary: AppColors.redS4,
        surface: AppColors.greyS1,
        surfaceTint: AppColors.blackS1,
        background: AppColors.greyS1,
        onBackground: AppColors.blackS4,
        shadow: Colors.black,
        brightness: Brightness.light,
      ),
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.blackS4,
      iconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.white,
      // ----------------------------------- TEXT
      fontFamily: AppFont.avenir,
      textTheme: ThemeData.dark().textTheme.copyWith(
            bodyMedium: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
      // ----------------------------------- DECORATION
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.white24,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.transparent,
      ),
      // ----------------------------------- WIDGET
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.blackS3,
        foregroundColor: Colors.white,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(kToolbarHeight * 0),
          ),
        ),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: AppColors.blackS3,
        elevation: 0,
        scrimColor: AppColors.blackS1.withOpacity(.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(0))),
      ),
      cardTheme: CardTheme(
        color: AppColors.blackS3,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kToolbarHeight * 0.2),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.blackS5,
        elevation: 0,
        selectedIconTheme: IconThemeData(color: AppColors.greyS1),
        unselectedIconTheme: IconThemeData(color: AppColors.blackS2),
        selectedItemColor: AppColors.greyS1,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedItemColor: AppColors.greyS6,
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.all(AppColors.primaryColor),
        visualDensity: VisualDensity.standard,
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
      // ----------------------------------- DIALOG & SHEET
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primaryColor,
        circularTrackColor: AppColors.primaryColor.withOpacity(.25),
        linearTrackColor: AppColors.primaryColor.withOpacity(.25),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColors.blackS1,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        actionsPadding: EdgeInsets.zero,
        contentTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 17,
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        elevation: 0,
        backgroundColor: AppColors.blackS3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(kToolbarHeight * 0.5),
          ),
        ),
      ),
      // ----------------------------------- BUTTON
      iconButtonTheme: const IconButtonThemeData(),
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.blackS1),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: AppColors.greyS1,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        menuStyle: MenuStyle(
          backgroundColor: MaterialStateProperty.all(AppColors.blackS1),
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          side: MaterialStateProperty.all(BorderSide.none),
          visualDensity: VisualDensity.comfortable,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.greyS2,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          fixedSize: MaterialStateProperty.all(const Size(1000, kToolbarHeight)),
          splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
          overlayColor: MaterialStateProperty.all(AppColors.secondaryColor),
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.secondaryColor;
              }
              return AppColors.blackS5;
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.pressed)) {
                return AppColors.blackS6;
              }
              return Colors.white;
            },
          ),
        ),
      ),
    );
