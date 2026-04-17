import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/settings_provider.dart';

// ── Theme State Management ──────────────────────────────────────────────────

class ThemeNotifier extends Notifier<ThemeMode> {
  static const String _themeKey = 'app_theme_mode';

  @override
  ThemeMode build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    final themeIndex = prefs.getInt(_themeKey);
    if (themeIndex == null) return ThemeMode.dark;
    return ThemeMode.values[themeIndex];
  }

  Future<void> toggleTheme(bool isDark) async {
    final prefs = ref.read(sharedPreferencesProvider);
    final newMode = isDark ? ThemeMode.dark : ThemeMode.light;
    await prefs.setInt(_themeKey, newMode.index);
    state = newMode;
  }

  void setTheme(ThemeMode mode) async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setInt(_themeKey, mode.index);
    state = mode;
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class AppTheme {
  // ── Palette: Dark Roast ──────────────────────────────────────────────────
  static const Color darkBg = Color(0xFF120C0B);
  static const Color darkSurface = Color(0xFF1D1513);
  static const Color darkPrimary = Color(0xFFD7CCC8); // Milk Foam
  static const Color darkAccent = Color(0xFFC6AC8F); // Crema Gold

  // ── Palette: Morning Crema (Light) ─────────────────────────────────────────
  static const Color lightBg = Color(0xFFFAF8F6); // Soft Bone
  static const Color lightSurface = Color(0xFFF2EFED); // Light Cream
  static const Color lightPrimary = Color(0xFF2D1E1B); // Rich Espresso
  static const Color lightAccent = Color(0xFFC8A96E); // Crema Gold
  static const Color lightTextSecondary = Color(0xFF6D4C41); // Soft Bean

  static ThemeData get darkTheme => _buildTheme(
        brightness: Brightness.dark,
        bg: darkBg,
        surface: darkSurface,
        primary: darkAccent, // Gold as primary in dark
        accent: darkAccent,
        textPrimary: Colors.white,
        textSecondary: Colors.white70,
      );

  static ThemeData get lightTheme => _buildTheme(
        brightness: Brightness.light,
        bg: lightBg,
        surface: lightSurface,
        primary: lightPrimary, // Espresso in light
        accent: lightAccent,
        textPrimary: lightPrimary,
        textSecondary: lightTextSecondary,
      );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color bg,
    required Color surface,
    required Color primary,
    required Color accent,
    required Color textPrimary,
    required Color textSecondary,
  }) {
    final base = brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();
    final isDark = brightness == Brightness.dark;

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
        onPrimary: isDark ? darkBg : Colors.white,
        onSecondary: isDark ? darkBg : Colors.white,
        onSurface: textPrimary,
        onSurfaceVariant: textSecondary,
        outline: primary.withValues(alpha: 0.2),
        outlineVariant: primary.withValues(alpha: 0.1),
      ),
      iconTheme: IconThemeData(
        color: isDark ? accent : primary,
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
        iconTheme: IconThemeData(color: isDark ? accent : primary),
        titleTextStyle: GoogleFonts.outfit(
          color: textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: isDark ? Colors.black : Colors.white,
        unselectedLabelColor: isDark ? Colors.white70 : textSecondary,
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
          foregroundColor: isDark ? darkBg : Colors.white,
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
        labelStyle: TextStyle(color: textSecondary),
        hintStyle: TextStyle(color: textSecondary),
      ),
      dividerTheme: DividerThemeData(
        color: textSecondary.withValues(alpha: 0.1),
        thickness: 1,
      ),
    );
  }
}
