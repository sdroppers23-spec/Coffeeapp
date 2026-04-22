import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PremiumAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final bool showBackButton;

  const PremiumAppBar({
    super.key,
    required this.title,
    this.actions,
    this.bottom,
    this.showBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: AppBar(
          backgroundColor: isDark 
              ? Colors.black.withValues(alpha: 0.2)
              : theme.colorScheme.surface.withValues(alpha: 0.7),
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: showBackButton 
              ? BackButton(color: theme.colorScheme.onSurface) 
              : null,
          title: Text(
            title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              fontSize: 22,
              color: theme.colorScheme.onSurface,
            ),
          ),
          centerTitle: false,
          actions: actions,
          bottom: bottom,
        ),
      ),
    );
  }

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }
}
