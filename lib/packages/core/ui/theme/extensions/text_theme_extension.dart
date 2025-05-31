import 'package:flutter/material.dart';

/// An extension of [ThemeData] that adds additional proterties for [Text] widgets
///
///
class TextThemeExtension extends ThemeExtension<TextThemeExtension> {
  const TextThemeExtension({
    required this.errorColor,
    required this.successColor,
  });

  final Color errorColor;
  final Color successColor;

  @override
  ThemeExtension<TextThemeExtension> copyWith({
    Color? errorColor,
    Color? successColor,
  }) {
    return TextThemeExtension(
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
    );
  }

  @override
  ThemeExtension<TextThemeExtension> lerp(covariant ThemeExtension<TextThemeExtension>? other, double t) {
    if (other is! TextThemeExtension) {
      return this;
    }
    return TextThemeExtension(
      successColor: Color.lerp(successColor, other.successColor, t) ?? successColor,
      errorColor: Color.lerp(errorColor, other.errorColor, t) ?? errorColor,
    );
  }
}
