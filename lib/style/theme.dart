import 'package:flutter/material.dart';
import 'package:taskroute/style/app_colors.dart';

class theme {
  static ThemeData themeLight = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: appColors.primaryColorLight,
        primary: appColors.primaryColorLight,
        onPrimary: appColors.onprimaryColorLight,
        secondary: appColors.secoundColorLight,
        tertiary: appColors.tritryColorLight,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        foregroundColor: appColors.primaryColorLight,
      ),
      textTheme: TextTheme(
        titleLarge: appColors.welcomeBack,
        titleSmall: appColors.underLineWelcomeBack,
        titleMedium: appColors.titleLabelStyle,
      ));

  static ThemeData themeDark = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: appColors.primaryColorDark,
        primary: appColors.primaryColorDark,
        onPrimary: appColors.onprimaryColorDark,
        secondary: appColors.secoundColorDark,
        tertiary: appColors.tritryColorDark,
      ),
      scaffoldBackgroundColor: Color(0xff060E1E),
      appBarTheme:
          AppBarTheme(color: Colors.transparent, foregroundColor: Colors.white),
      textTheme: TextTheme(
        titleLarge: appColors.welcomeBack.copyWith(color: Colors.white),
        titleSmall: appColors.underLineWelcomeBack,
        titleMedium: appColors.titleLabelStyle
            .copyWith(color: appColors.primaryColorDark),
      ));
}
