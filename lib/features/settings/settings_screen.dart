import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../navigation/navigation_providers.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/providers/preferences_provider.dart';
import '../../shared/widgets/premium_background.dart';
import '../../core/database/database_provider.dart';

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

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇺🇸'},
    {'code': 'uk', 'name': 'Українська', 'flag': '🇺🇦'},
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'it', 'name': 'Italiano', 'flag': '🇮🇹'},
    {'code': 'pt', 'name': 'Português', 'flag': '🇵🇹'},
  ];

  Future<void> _signOut() async {
    setState(() => _isLoading = true);
    try {
      // 1. Try to sync before clearing (only if not guest)
      if (!ref.read(isGuestProvider)) {
        try {
          await ref
              .read(syncServiceProvider)
              .pushLocalUserContent()
              .timeout(const Duration(seconds: 10));
        } catch (e) {
          debugPrint('Logout: Pre-logout sync failed: $e');
        }
      }

      await ref.read(databaseProvider).clearUserData();
      await ref.read(supabaseProvider).auth.signOut();
      if (mounted) context.go('/auth');
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              ref.t('sign_out_error', args: {'error': e.toString()}),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (ref.watch(isGuestProvider))
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.orange.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline_rounded,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                ref.t('guest_mode_notice'),
                                style: GoogleFonts.outfit(
                                  fontSize: 13,
                                  color: Colors.orange.shade200,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  _buildSectionTitle(context, ref.t('language').toUpperCase()),
                  _buildCard(
                    context,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
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
                          SizedBox(
                            width: 150,
                            height: 60,
                            child: ListWheelScrollView.useDelegate(
                              itemExtent: 32,
                              physics: const FixedExtentScrollPhysics(),
                              perspective: 0.008,
                              diameterRatio: 1.5,
                              squeeze: 1.2,
                              onSelectedItemChanged: (index) {
                                final code = _languages[index]['code']!;
                                if (ref.read(localeProvider) != code) {
                                  ref.read(localeProvider.notifier).setLocale(
                                    code,
                                  );
                                  ref
                                      .read(settingsProvider.notifier)
                                      .triggerSelectionVibrate();
                                }
                              },
                              controller: FixedExtentScrollController(
                                initialItem: _languages.indexWhere(
                                  (l) => l['code'] == ref.read(localeProvider),
                                ),
                              ),
                              childDelegate: ListWheelChildBuilderDelegate(
                                childCount: _languages.length,
                                builder: (context, index) {
                                  final lang = _languages[index];
                                  final isSelected =
                                      ref.watch(localeProvider) == lang['code'];
                                  return Center(
                                    child: AnimatedDefaultTextStyle(
                                      duration: const Duration(
                                        milliseconds: 200,
                                      ),
                                      style: GoogleFonts.outfit(
                                        color: isSelected
                                            ? theme.colorScheme.primary
                                            : Colors.white38,
                                        fontSize: isSelected ? 15 : 13,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(lang['flag']!),
                                          const SizedBox(width: 8),
                                          Text(lang['name']!),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
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
                  // ОДИНИЦІ ВИМІРУ
                  _buildSectionTitle(context, ref.t('units')),
                  _buildCard(
                    context,
                    child: Column(
                      children: [
                        _buildTogglePreference(
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
                        _buildTogglePreference(
                          context,
                          icon: Icons.straighten_rounded,
                          title: ref.t('distance'),
                          value: prefs.lengthUnit == LengthUnit.feet,
                          offLabel: ref.t('meters_short'),
                          onLabel: ref.t('feet_short'),
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
    
                  const SizedBox(height: 48),
    
                  // Bottom button
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (ref.read(isGuestProvider)) {
                          ref.read(isGuestProvider.notifier).setGuest(false);
                          context.go('/auth');
                        } else {
                          _signOut();
                        }
                      },
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              ref.watch(isGuestProvider)
                                  ? ref.t('log_in')
                                  : ref.t('sign_out_account'),
                              style: GoogleFonts.poppins(
                                color: ref.watch(isGuestProvider)
                                    ? theme.colorScheme.primary
                                    : const Color(0xFFE57373),
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

  Widget _buildTogglePreference(
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildToggleButton(
                  context,
                  label: offLabel,
                  isSelected: !value,
                  onTap: () => onChanged(false),
                ),
                _buildToggleButton(
                  context,
                  label: onLabel,
                  isSelected: value,
                  onTap: () => onChanged(true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        ref.read(settingsProvider.notifier).triggerSelectionVibrate();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            color: isSelected
                ? Colors.black
                : theme.colorScheme.onSurface.withValues(alpha: 0.85),
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
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
                        color: isSelected
                            ? Colors.black
                            : Colors.white.withValues(alpha: 0.85),
                        fontSize: 12,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w600,
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
}
