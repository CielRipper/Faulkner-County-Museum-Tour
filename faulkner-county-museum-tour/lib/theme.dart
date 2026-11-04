import 'package:flutter/material.dart';

/// Colors pulled from faulknerhistory.org and the museum's Facebook page.
class MuseumColors {
  static const maroon = Color(0xFF600000); // website header band
  static const linen = Color(0xFFF3EEE6); // website background
  static const green = Color(0xFF1E6B3A); // website link color
  static const ink = Color(0xFF2B2B2B); // main text
  static const muted = Color(0xFF6B6259); // secondary text
  static const placeholder = Color(0xFFE4DCCF); // empty image boxes
}

/// Serif headings like the website's titles.
/// 'serif' uses the phone's built-in serif font.
const String headingFont = 'serif';

ThemeData buildMuseumTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MuseumColors.maroon,
      primary: MuseumColors.maroon,
      secondary: MuseumColors.green,
      surface: Colors.white,
    ),
    scaffoldBackgroundColor: MuseumColors.linen,
  );

  final text = base.textTheme
      .apply(bodyColor: MuseumColors.ink, displayColor: MuseumColors.ink);

  return base.copyWith(
    textTheme: text.copyWith(
      headlineSmall: text.headlineSmall?.copyWith(
        fontFamily: headingFont,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: text.titleLarge?.copyWith(
        fontFamily: headingFont,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: text.titleMedium?.copyWith(
        fontFamily: headingFont,
        fontWeight: FontWeight.bold,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: MuseumColors.maroon,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: headingFont,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: MuseumColors.green),
    ),
    dividerTheme: const DividerThemeData(color: MuseumColors.placeholder),
  );
}