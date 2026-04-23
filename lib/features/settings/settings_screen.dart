import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../navigation/navigation_providers.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/providers/design_theme_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import '../../shared/widgets/premium_background.dart';
// import '../../shared/widgets/premium_background.dart'; // Removed unused import

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(navBarVisibleProvider.notifier).hide();
      }
    });
  }

  @override
  void dispose() {
    ref.read(navBarVisibleProvider.notifier).show();
    super.dispose();
  }

  Future<void> _signOut() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(supabaseProvider).auth.signOut();
      if (mounted) context.go('/auth');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }





  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.colorScheme.onSurface,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          ref.t('settings'),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: theme.colorScheme.onSurface,
          ),
        ),
        centerTitle: false,
      ),
      body: PremiumBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // МОВА
            _buildSectionTitle(context, ref.t('language').toUpperCase()),
            _buildCard(
              context,
              child: PopupMenuButton<String>(
                onSelected: (code) {
                  ref.read(localeProvider.notifier).setLocale(code);
                  setState(() {});
                },
                offset: const Offset(0, 50),
                color: theme.cardColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'en',
                    child: Row(
                      children: [
                        const Text('🇺🇸 English'),
                        if (ref.read(localeProvider) == 'en') ...[
                          const Spacer(),
                          Icon(Icons.check, color: theme.colorScheme.primary, size: 18),
                        ],
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'uk',
                    child: Row(
                      children: [
                        const Text('🇺🇦 Українська'),
                        if (ref.read(localeProvider) == 'uk') ...[
                          const Spacer(),
                          Icon(Icons.check, color: theme.colorScheme.primary, size: 18),
                        ],
                      ],
                    ),
                  ),
                ],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.language_rounded,
                        color: theme.colorScheme.primary,
                        size: 22,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        ref.t('language'),
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        ref.watch(localeProvider) == 'uk' ? 'Українська' : 'English',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          color: Colors.white38,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white24,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),
            ),


            // ВІБРАЦІЯ
            _buildSectionTitle(context, 'ВІБРАЦІЯ'),
            _buildCard(
              context,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Тактильний відгук',
                            style: GoogleFonts.outfit(
                              color: theme.colorScheme.onSurface,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Легка вібрація при натисканні та\nутриманні',
                            style: GoogleFonts.outfit(
                              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                              fontSize: 13,
                              height: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: ref.watch(settingsProvider),
                      activeThumbColor: theme.colorScheme.secondary,
                      activeTrackColor: theme.colorScheme.secondary.withValues(alpha: 0.2),
                      inactiveThumbColor: Colors.grey[400],
                      inactiveTrackColor: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                      onChanged: (val) {
                        ref.read(settingsProvider.notifier).toggleVibration(val);
                      },
                    ),
                  ],
                ),
              ),
            ),


            // СТИЛЬ ДИЗАЙНУ
            _buildSectionTitle(context, ref.t('design_theme').toUpperCase()),
            _buildCard(
              context,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildThemeOption(
                      context,
                      ref: ref,
                      theme: AppDesignTheme.glass,
                      label: ref.t('design_glass'),
                      icon: Icons.auto_awesome_rounded,
                    ),
                    const SizedBox(height: 12),
                    _buildThemeOption(
                      context,
                      ref: ref,
                      theme: AppDesignTheme.coffee,
                      label: ref.t('design_coffee'),
                      icon: Icons.coffee_rounded,
                    ),
                  ],
                ),
              ),
            ),

            // ЮРИДИЧНА ІНФОРМАЦІЯ
            _buildSectionTitle(context, 'ЮРИДИЧНА ІНФОРМАЦІЯ'),
            _buildCard(
              context,
              child: Column(
                children: [
                  _buildListItem(
                    context,
                    icon: Icons.lock_outline_rounded,
                    title: 'Політика конфіденційності',
                    onTap: () {},
                  ),
                  Divider(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                  ),
                  _buildListItem(
                    context,
                    icon: Icons.insert_drive_file_outlined,
                    title: 'Умови використання',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ПІДТРИМКА
            _buildSectionTitle(context, 'ПІДТРИМКА'),
            _buildCard(
              context,
              child: Column(
                children: [
                  _buildListItem(
                    context,
                    icon: Icons.help_outline_rounded,
                    title: 'Служба підтримки',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // ТЕСТУВАННЯ ТА РОЗРОБКА
            _buildSectionTitle(context, 'ТЕСТУВАННЯ ТА РОЗРОБКА'),
            _buildCard(
              context,
              child: Column(
                children: [
                  _buildListItem(
                    context,
                    icon: Icons.bug_report_outlined,
                    title: 'Тестувати новий діалог рецептів',
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => const AddRecipeDialog(
                          lotId: 'test_lot',
                          initialMethod: 'v60',
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            // Bottom button
            Center(
              child: GestureDetector(
                onTap: _signOut,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        'Вийти з акаунта',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFE57373),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildSectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: isDark ? theme.colorScheme.primary : theme.colorScheme.primary.withValues(alpha: 0.6),
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, {required Widget child}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF111111) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark 
              ? theme.colorScheme.onSurface.withValues(alpha: 0.05)
              : theme.colorScheme.primary.withValues(alpha: 0.08),
        ),
        boxShadow: isDark ? null : [
          BoxShadow(
            color: theme.colorScheme.primary.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required WidgetRef ref,
    required AppDesignTheme theme,
    required String label,
    required IconData icon,
  }) {
    final currentTheme = ref.watch(designThemeProvider);
    final isSelected = currentTheme == theme;
    final themeData = Theme.of(context);

    return GestureDetector(
      onTap: () {
        ref.read(settingsProvider.notifier).triggerSelectionVibrate();
        ref.read(designThemeProvider.notifier).setTheme(theme);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? themeData.colorScheme.primary.withValues(alpha: 0.1) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? themeData.colorScheme.primary.withValues(alpha: 0.3) 
                : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? themeData.colorScheme.primary : Colors.white38,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.outfit(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: themeData.colorScheme.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.outfit(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
}
