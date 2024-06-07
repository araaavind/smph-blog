import 'package:flutter/material.dart';
import 'package:semaphore/core/theme/app_palette.dart';

class AppTheme {
  static _border([Color color = AppPalette.borderColor]) =>
      UnderlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1,
        ),
      );

  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: AppPalette.backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppPalette.backgroundColor,
        scrolledUnderElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(18),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(AppPalette.gradient2),
        errorBorder: _border(AppPalette.errorColor),
      ),
      chipTheme: const ChipThemeData(
        color: WidgetStatePropertyAll(
          AppPalette.backgroundColor,
        ),
        side: BorderSide.none,
      ));
}
