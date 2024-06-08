import 'package:flutter/material.dart';

class AppPalette {
  static const Color backgroundColor = Color.fromRGBO(250, 250, 255, 1);
  static const Color gradient1 = Color.fromRGBO(255, 162, 224, 1);
  static const Color gradient2 = Color.fromRGBO(255, 150, 194, 1);
  static const Color gradient3 = Color.fromRGBO(255, 171, 152, 1);
  static const Color borderColor = Color.fromRGBO(169, 169, 185, 1);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Color.fromARGB(255, 109, 109, 109);
  static const Color errorColor = Color.fromARGB(255, 255, 120, 120);
  static const Color transparentColor = Colors.transparent;
  static const Color blogCardColor = Color.fromRGBO(240, 234, 237, 1);
  static const Color textOnBackgroundColor = Colors.white;

  static const Color backgroundColorDark = Color.fromRGBO(9, 9, 9, 1);
  static const Color gradient1Dark = Color.fromRGBO(227, 115, 190, 1);
  static const Color gradient2Dark = Color.fromRGBO(196, 90, 134, 1);
  static const Color gradient3Dark = Color.fromRGBO(231, 135, 114, 1);
  static const Color borderColorDark = Color.fromRGBO(46, 46, 56, 1);
  static const Color whiteColorDark = Colors.white;
  static const Color greyColorDark = Color.fromARGB(255, 200, 200, 200);
  static const Color errorColorDark = Colors.redAccent;
  static const Color transparentColorDark = Colors.transparent;
  static const Color blogCardColorDark = Color.fromRGBO(47, 47, 60, 1);
}

@immutable
class CardOverlayGradientColors
    extends ThemeExtension<CardOverlayGradientColors> {
  final Color? overlayGradientOne;
  final Color? overlayGradientTwo;

  const CardOverlayGradientColors({
    required this.overlayGradientOne,
    required this.overlayGradientTwo,
  });

  @override
  CardOverlayGradientColors copyWith({
    Color? overlayGradientOne,
    Color? overlayGradientTwo,
  }) {
    return CardOverlayGradientColors(
      overlayGradientOne: overlayGradientOne ?? this.overlayGradientOne,
      overlayGradientTwo: overlayGradientTwo ?? this.overlayGradientTwo,
    );
  }

  @override
  CardOverlayGradientColors lerp(CardOverlayGradientColors? other, double t) {
    if (other is! CardOverlayGradientColors) {
      return this;
    }

    return CardOverlayGradientColors(
      overlayGradientOne:
          Color.lerp(overlayGradientOne, other.overlayGradientOne, t),
      overlayGradientTwo:
          Color.lerp(overlayGradientTwo, other.overlayGradientTwo, t),
    );
  }
}
