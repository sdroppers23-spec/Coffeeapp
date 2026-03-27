import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// ── Theme State Management ──────────────────────────────────────────────────
// Fixed to single Dark mode as per user request
final themeProvider = Provider<ThemeMode>((ref) => ThemeMode.dark);

class AppTheme {
  // ── Palette: Hearth & Bean ───────────────────────────────────────────────
  static const Color darkBg = Color(0xFF120C0B);
  static const Color darkSurface = Color(0xFF1D1513);
  static const Color darkPrimary = Color(0xFFD7CCC8); // Milk Foam
  static const Color darkAccent = Color(0xFFC6AC8F); // Crema Gold

  static ThemeData get theme => _buildTheme(
      brightness: Brightness.dark,
      bg: darkBg,
      surface: darkSurface,
      primary: darkPrimary,
      accent: darkAccent,
      textPrimary: Colors.white,
      textSecondary: Colors.white70,
    );

  // Compatibility getters for existing code
  static ThemeData get darkTheme => theme;
  static ThemeData get lightTheme => theme; // Always use dark brown as per user request

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
    
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: bg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        primary: primary,
        secondary: accent,
        surface: surface,
        onPrimary: bg,
        onSecondary: bg,
        onSurface: textPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        displayLarge: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.poppins(color: textPrimary, fontWeight: FontWeight.w600),
        bodyLarge: GoogleFonts.inter(color: textPrimary),
        bodyMedium: GoogleFonts.inter(color: textSecondary),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
        titleTextStyle: GoogleFonts.poppins(
          color: primary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: bg,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surface,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        labelStyle: TextStyle(color: textSecondary),
        hintStyle: TextStyle(color: textSecondary),
      ),
    );
  }
}
