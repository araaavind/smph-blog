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
    scaffoldBackgroundColor: AppPalette.backgroundColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.backgroundColorDark,
      foregroundColor: Colors.white,
      scrolledUnderElevation: 0,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(10, 10, 10, 1),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(18),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.gradient2Dark),
      errorBorder: _border(AppPalette.errorColorDark),
    ),
    chipTheme: const ChipThemeData(
      color: WidgetStatePropertyAll(
        AppPalette.backgroundColorDark,
      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      side: BorderSide.none,
    ),
    cardColor: AppPalette.blogCardColorDark,
    extensions: [
      CardOverlayGradientColors(
        overlayGradientOne: Colors.black.withOpacity(0.8),
        overlayGradientTwo: Colors.black.withOpacity(0.5),
      )
    ],
  );

  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPalette.backgroundColor,
      foregroundColor: Colors.black,
      scrolledUnderElevation: 0,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color.fromRGBO(244, 244, 244, 1),
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
      labelStyle: TextStyle(
        color: Colors.black,
      ),
      side: BorderSide.none,
    ),
    cardColor: AppPalette.blogCardColor,
    extensions: [
      CardOverlayGradientColors(
        overlayGradientOne: Colors.white,
        overlayGradientTwo: Colors.white.withOpacity(0.8),
      )
    ],
  );
}
