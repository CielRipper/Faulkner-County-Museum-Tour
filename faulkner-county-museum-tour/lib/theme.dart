import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colors pulled from faulknerhistory.org and the museum's Facebook page.
class MuseumColors {
  static const maroon = Color(0xFF600000); // website header band
  static const linen = Color(0xFFF3EEE6); // website background
  static const green = Color(0xFF1E6B3A); // website link color
  static const ink = Color(0xFF2B2B2B); // main text
  static const muted = Color(0xFF6B6259); // secondary text
  static const placeholder = Color(0xFFE4DCCF); // empty image boxes
  static const paper = Color(0xFFFBF7EF); // cards, like old paper
  static const border = Color(0xFFD8CCB8); // thin card borders
}

/// Fonts: Arvo (a slab serif like the Historical Society website's headings)
/// for headings, and Lora (a book-style serif) for body text.
/// Sizes are a bit larger than Flutter's defaults so they're easier to read
/// in the museum (issue #20).
ThemeData buildMuseumTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: MuseumColors.maroon,
      primary: MuseumColors.maroon,
      secondary: MuseumColors.green,
      surface: MuseumColors.paper,
    ),
    scaffoldBackgroundColor: MuseumColors.linen,
  );

  // Lora for everything, then Arvo for the headings and titles.
  final body = GoogleFonts.loraTextTheme(base.textTheme)
      .apply(bodyColor: MuseumColors.ink, displayColor: MuseumColors.ink);

  TextStyle? heading(TextStyle? style, double size) => style == null
      ? null
      : GoogleFonts.arvo(
          textStyle: style,
          fontSize: size,
          fontWeight: FontWeight.bold,
        );

  return base.copyWith(
    textTheme: body.copyWith(
      // Headings (Arvo)
      headlineSmall: heading(body.headlineSmall, 26),
      titleLarge: heading(body.titleLarge, 22),
      titleMedium: heading(body.titleMedium, 18),
      // Body text (Lora), a little larger than the defaults
      titleSmall: body.titleSmall?.copyWith(fontSize: 16),
      bodyLarge: body.bodyLarge?.copyWith(fontSize: 18),
      bodyMedium: body.bodyMedium?.copyWith(fontSize: 16),
      bodySmall: body.bodySmall?.copyWith(fontSize: 14),
      labelLarge: body.labelLarge?.copyWith(fontSize: 16),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: MuseumColors.maroon,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: GoogleFonts.arvo(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    // Cards look like old paper: cream with a thin brown border, no shadow.
    cardTheme: CardThemeData(
      color: MuseumColors.paper,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: MuseumColors.border),
      ),
    ),
    // Popups match the paper cards instead of Material's default pink.
    dialogTheme: const DialogThemeData(
      backgroundColor: MuseumColors.paper,
      surfaceTintColor: Colors.transparent,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: MuseumColors.green),
    ),
    dividerTheme: const DividerThemeData(color: MuseumColors.border),
    // Bottom nav bar: paper colored with a maroon highlight instead of pink.
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: MuseumColors.paper,
      indicatorColor: MuseumColors.maroon,
      surfaceTintColor: Colors.transparent,
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return IconThemeData(
          color: states.contains(WidgetState.selected)
              ? Colors.white
              : MuseumColors.muted,
        );
      }),
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        final selected = states.contains(WidgetState.selected);
        return GoogleFonts.lora(
          fontSize: 13,
          color: selected ? MuseumColors.maroon : MuseumColors.muted,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        );
      }),
    ),
  );
}