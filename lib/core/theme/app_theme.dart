import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';


// ── Theme State Management ──────────────────────────────────────────────────

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.dark;

  Future<void> toggleTheme(bool isDark) async {
    // No-op as light theme is removed
  }

  void setTheme(ThemeMode mode) async {
    // Always dark
    state = ThemeMode.dark;
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class AppTheme {
  // ── Palette: Dark Roast ──────────────────────────────────────────────────
  static const Color darkBg = Color(0xFF0A0908);
  static const Color darkSurface = Color(0xFF1D1513);
  static const Color darkPrimary = Color(0xFFD7CCC8); // Milk Foam
  static const Color darkAccent = Color(0xFFC6AC8F); // Crema Gold

  static ThemeData get darkTheme => _buildTheme();

  static ThemeData _buildTheme() {
    const brightness = Brightness.dark;
    const bg = darkBg;
    const surface = darkSurface;
    const primary = darkAccent; // Gold as primary
    const accent = darkAccent;
    const textPrimary = Colors.white;
    const textSecondary = Colors.white70;

    final base = ThemeData.dark();

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      primaryColor: primary,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        primary: primary,
        secondary: accent,
        surface: surface,
        surfaceContainerLow: surface,
        onPrimary: darkBg,
        onSecondary: darkBg,
        onSurface: textPrimary,
        onSurfaceVariant: textSecondary,
        outline: primary.withValues(alpha: 0.2),
        outlineVariant: primary.withValues(alpha: 0.1),
      ),
      iconTheme: const IconThemeData(
        color: accent,
        size: 24,
      ),
      textTheme: GoogleFonts.outfitTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: GoogleFonts.outfit(
          color: textPrimary,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: GoogleFonts.outfit(color: textPrimary),
        bodyMedium: GoogleFonts.outfit(color: textSecondary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: accent),
        titleTextStyle: GoogleFonts.outfit(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        unselectedLabelStyle: GoogleFonts.outfit(
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: darkBg,
          minimumSize: const Size.fromHeight(56),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        labelStyle: const TextStyle(color: textSecondary),
        hintStyle: const TextStyle(color: textSecondary),
      ),
      dividerTheme: DividerThemeData(
        color: textSecondary.withValues(alpha: 0.1),
        thickness: 1,
      ),
    );
  }
}
