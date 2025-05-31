import 'package:catppuccin_flutter/catppuccin_flutter.dart';
import 'package:flutter/material.dart';

import 'extensions/text_theme_extension.dart';

/// A utility class that provides [ThemeData]
/// for both *dark* and *light* mode
final class AppTheme {
  /// Get [ThemeData] for *dark* mode
  static ThemeData getDarktheme() {
    return _catppuccinTheme(catppuccin.mocha);
  }

  /// Get [ThemeData] for *light* mode
  static ThemeData getLightTheme() {
    return _catppuccinTheme(catppuccin.latte);
  }

  static ThemeData _catppuccinTheme(Flavor flavor) {
    Color primaryColor = flavor.mauve;
    Color secondaryColor = flavor.pink;
    return ThemeData(
      useMaterial3: true,
//      fontFamily: 'Poppins',
      extensions: {
        TextThemeExtension(
          errorColor: flavor.red,
          successColor: flavor.green,
        ),
      },
      appBarTheme: AppBarTheme(
        elevation: 0,
        titleTextStyle: TextStyle(color: flavor.text, fontSize: 20, fontWeight: FontWeight.bold),
        backgroundColor: flavor.crust,
        foregroundColor: flavor.pink,
      ),
      colorScheme: ColorScheme(
        surface: flavor.base,
        brightness: Brightness.light,
        error: flavor.red,
        inversePrimary: flavor.base,
        // onBackground: flavor.text,
        onError: flavor.text,
        onPrimary: primaryColor,
        onSecondary: secondaryColor,
        onSurface: flavor.text,
        primary: flavor.crust,
        secondary: flavor.mantle,
        // surface: flavor.surface0,
      ),
      scaffoldBackgroundColor: flavor.crust,
      textTheme: const TextTheme()
          .apply(
            bodyColor: flavor.text,
            displayColor: primaryColor,
          )
          .copyWith(
            bodySmall: TextStyle(
              color: flavor.overlay1,
            ),
            titleSmall: TextStyle(
              color: flavor.pink,
            ),
            bodyMedium: TextStyle(
              color: flavor.overlay2,
            ),
          ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        backgroundColor: flavor.base,
      ),
      switchTheme: SwitchThemeData(
        trackOutlineColor: WidgetStateColor.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return flavor.surface2;
          }
          return flavor.overlay2;
        }),
        trackColor: WidgetStateColor.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return flavor.green.withValues(alpha: 0.1);
          }
          return flavor.overlay0;
        }),
        thumbColor: WidgetStateColor.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return flavor.green;
          }
          return flavor.crust;
        }),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: flavor.rosewater,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: flavor.pink,
          foregroundColor: flavor.crust,
        ),
      ),
      iconTheme: IconThemeData(
        color: flavor.peach,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: flavor.mauve,
        circularTrackColor: flavor.overlay0,
      ),
      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(4),
        side: const BorderSide(
          width: 0,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: flavor.subtext1,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: flavor.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: flavor.mauve,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: flavor.overlay1,
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: flavor.yellow,
        selectionHandleColor: flavor.yellow,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        // fillColor: WidgetStatePropertyAll(flavor.mauve),
        fillColor: WidgetStateColor.resolveWith((state) {
          if (state.contains(WidgetState.selected)) {
            return flavor.mauve;
          }
          return flavor.crust;
        }),
        side: BorderSide(color: flavor.mauve),
        overlayColor: WidgetStatePropertyAll(flavor.overlay0),
        checkColor: WidgetStatePropertyAll(flavor.crust),
        visualDensity: VisualDensity.comfortable,
      ),
    );
  }
}
