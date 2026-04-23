import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../navigation/navigation_providers.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/providers/design_theme_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../shared/widgets/add_recipe_dialog.dart';
import '../../core/providers/preferences_provider.dart';
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
    final isUk = ref.watch(localeProvider) == 'uk';
    final prefs = ref.watch(preferencesProvider);

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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'en',
                      child: Row(
                        children: [
                          const Text('🇺🇸 English'),
                          if (ref.read(localeProvider) == 'en') ...[
                            const Spacer(),
                            Icon(
                              Icons.check,
                              color: theme.colorScheme.primary,
                              size: 18,
                            ),
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
                            Icon(
                              Icons.check,
                              color: theme.colorScheme.primary,
                              size: 18,
                            ),
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
                          ref.watch(localeProvider) == 'uk'
                              ? 'Українська'
                              : 'English',
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
              _buildSectionTitle(context, ref.t('vibration')),
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
                              ref.t('haptic_feedback'),
                              style: GoogleFonts.outfit(
                                color: theme.colorScheme.onSurface,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ref.t('haptic_desc'),
                              style: GoogleFonts.outfit(
                                color: theme.colorScheme.onSurface.withValues(
                                  alpha: 0.5,
                                ),
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
                        activeTrackColor: theme.colorScheme.secondary
                            .withValues(alpha: 0.2),
                        inactiveThumbColor: Colors.grey[400],
                        inactiveTrackColor: theme.colorScheme.onSurface
                            .withValues(alpha: 0.1),
                        onChanged: (val) {
                          ref
                              .read(settingsProvider.notifier)
                              .toggleVibration(val);
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

              // ОДИНИЦІ ВИМІРУ
              _buildSectionTitle(context, ref.t('units')),
              _buildCard(
                context,
                child: Column(
                  children: [
                    _buildSwitchPreference(
                      context,
                      icon: Icons.thermostat_rounded,
                      title: ref.t('temperature'),
                      value: prefs.tempUnit == TempUnit.fahrenheit,
                      offLabel: '°C',
                      onLabel: '°F',
                      onChanged: (val) {
                        ref
                            .read(preferencesProvider.notifier)
                            .setTempUnit(
                              val ? TempUnit.fahrenheit : TempUnit.celsius,
                            );
                      },
                    ),
                    _buildDivider(theme),
                    _buildSwitchPreference(
                      context,
                      icon: Icons.straighten_rounded,
                      title: ref.t('distance'),
                      value: prefs.lengthUnit == LengthUnit.feet,
                      offLabel: isUk ? 'М' : 'M',
                      onLabel: isUk ? 'Ф' : 'FT',
                      onChanged: (val) {
                        ref
                            .read(preferencesProvider.notifier)
                            .setLengthUnit(
                              val ? LengthUnit.feet : LengthUnit.meters,
                            );
                      },
                    ),
                    _buildDivider(theme),
                    _buildCurrencyPreference(context, ref, prefs),
                  ],
                ),
              ),

              // ЮРИДИЧНА ІНФОРМАЦІЯ
              _buildSectionTitle(context, ref.t('legal')),
              _buildCard(
                context,
                child: Column(
                  children: [
                    _buildListItem(
                      context,
                      icon: Icons.lock_outline_rounded,
                      title: ref.t('privacy_policy'),
                      onTap: () {},
                    ),
                    _buildDivider(theme),
                    _buildListItem(
                      context,
                      icon: Icons.insert_drive_file_outlined,
                      title: ref.t('terms_of_use'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ПІДТРИМКА
              _buildSectionTitle(context, ref.t('support')),
              _buildCard(
                context,
                child: Column(
                  children: [
                    _buildListItem(
                      context,
                      icon: Icons.help_outline_rounded,
                      title: ref.t('customer_support'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // ТЕСТУВАННЯ ТА РОЗРОБКА
              _buildSectionTitle(context, ref.t('debug')),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    _buildGlassRecipeTile(
                      context: context,
                      title: ref.t('espresso'),
                      subtitle: ref.t('quick_recipe'),
                      icon: Icons.coffee_maker_rounded,
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => const AddRecipeDialog(
                            lotId: 'test_lot',
                            initialMethod: 'espresso',
                          ),
                        );
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildGlassRecipeTile(
                      context: context,
                      title: ref.t('filter'),
                      subtitle: ref.t('v60_chemex'),
                      icon: Icons.coffee_outlined,
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
                          ref.t('sign_out_account'),
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
          color: isDark
              ? theme.colorScheme.primary
              : theme.colorScheme.primary.withValues(alpha: 0.6),
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
        boxShadow: isDark
            ? null
            : [
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
              color: isSelected
                  ? themeData.colorScheme.primary
                  : Colors.white38,
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

  Widget _buildSwitchPreference(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool value,
    required String offLabel,
    required String onLabel,
    required ValueChanged<bool> onChanged,
  }) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
          Text(
            offLabel,
            style: GoogleFonts.outfit(
              color: !value ? theme.colorScheme.primary : Colors.white24,
              fontSize: 14,
              fontWeight: !value ? FontWeight.bold : FontWeight.w400,
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: value,
            activeTrackColor: theme.colorScheme.primary.withValues(alpha: 0.2),
            activeThumbColor: theme.colorScheme.primary,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8),
          Text(
            onLabel,
            style: GoogleFonts.outfit(
              color: value ? theme.colorScheme.primary : Colors.white24,
              fontSize: 14,
              fontWeight: value ? FontWeight.bold : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurrencyPreference(
    BuildContext context,
    WidgetRef ref,
    UserPreferences prefs,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            Icons.payments_outlined,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              ref.t('currency'),
              style: GoogleFonts.outfit(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: Currency.values.map((c) {
                final isSelected = prefs.currency == c;
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(settingsProvider.notifier)
                        .triggerSelectionVibrate();
                    ref.read(preferencesProvider.notifier).setCurrency(c);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _currencySymbolOnly(c),
                      style: GoogleFonts.outfit(
                        color: isSelected ? Colors.black : Colors.white38,
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _currencySymbolOnly(Currency c) {
    switch (c) {
      case Currency.uah:
        return '₴';
      case Currency.eur:
        return '€';
      case Currency.usd:
        return '\$';
    }
  }

  Widget _buildDivider(ThemeData theme) {
    return Divider(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
      height: 1,
      indent: 16,
      endIndent: 16,
    );
  }

  Widget _buildGlassRecipeTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0.08),
                Colors.white.withValues(alpha: 0.03),
              ],
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Stack(
                children: [
                  Positioned(
                    right: -10,
                    bottom: -10,
                    child: Icon(
                      icon,
                      size: 80,
                      color: Colors.white.withValues(alpha: 0.05),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            icon,
                            color: theme.colorScheme.primary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          title,
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: GoogleFonts.outfit(
                            color: Colors.white38,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
