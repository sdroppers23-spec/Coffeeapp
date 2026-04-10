import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/providers/settings_provider.dart';
import '../../shared/widgets/glass_container.dart';
import '../../shared/widgets/premium_background.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _isLoading = false;

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
    return PremiumBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            ref.t('settings'),
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(ref.t('language')),
              _buildGlassCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.language,
                          color: Colors.white70,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _getLanguageName(ref.watch(localeProvider)),
                          style: GoogleFonts.outfit(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    DropdownButton<String>(
                      value: ref.watch(localeProvider),
                      dropdownColor: const Color(0xFF1E1E1E),
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFFC8A96E),
                      ),
                      onChanged: (val) {
                        if (val != null) {
                          ref.read(localeProvider.notifier).setLocale(val);
                        }
                      },
                      items: const [
                        DropdownMenuItem(value: 'en', child: Text('English')),
                        DropdownMenuItem(
                          value: 'uk',
                          child: Text('Українська'),
                        ),
                        DropdownMenuItem(value: 'ru', child: Text('Русский')),
                        DropdownMenuItem(value: 'fr', child: Text('Français')),
                        DropdownMenuItem(value: 'de', child: Text('Deutsch')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(ref.t('vibration')),
              _buildGlassCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ref.t('enable_vibration'),
                            style: GoogleFonts.outfit(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            ref.t('haptic_desc'),
                            style: GoogleFonts.outfit(
                              color: Colors.white38,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: ref.watch(settingsProvider),
                      activeThumbColor: const Color(0xFFC8A96E),
                      onChanged: (val) {
                        ref
                            .read(settingsProvider.notifier)
                            .toggleVibration(val);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              TextButton.icon(
                onPressed: () =>
                    ref.read(settingsProvider.notifier).triggerVibrate(),
                icon: const Icon(
                  Icons.vibration,
                  color: Color(0xFFC8A96E),
                  size: 16,
                ),
                label: Text(
                  'TEST HAPTIC',
                  style: GoogleFonts.outfit(
                    color: const Color(0xFFC8A96E),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(ref.t('legal')),
              _buildGlassCard(
                child: Column(
                  children: [
                    _buildSettingsItem(
                      icon: Icons.privacy_tip_outlined,
                      title: ref.t('privacy_policy'),
                      onTap: () =>
                          _showPolicyDialog(context, ref.t('privacy_policy')),
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    _buildSettingsItem(
                      icon: Icons.description_outlined,
                      title: ref.t('terms_of_use'),
                      onTap: () =>
                          _showPolicyDialog(context, ref.t('terms_of_use')),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle(ref.t('support')),
              _buildGlassCard(
                child: Column(
                  children: [
                    _buildSettingsItem(
                      icon: Icons.mail_outline,
                      title: ref.t('contact_us'),
                      onTap: () {
                        // Placeholder for contact action
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Redirecting to support...'),
                          ),
                        );
                      },
                    ),
                    const Divider(color: Colors.white10, height: 1),
                    _buildSettingsItem(
                      icon: Icons.star_outline,
                      title: ref.t('rate_app'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: _buildGlassCard(
                  opacity: 0.05,
                  padding: EdgeInsets.zero,
                  child: InkWell(
                    onTap: _signOut,
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                ref.t('logout'),
                                style: GoogleFonts.outfit(
                                  color: Colors.redAccent,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Version 1.2.0 (Build 42)',
                  style: GoogleFonts.outfit(
                    color: Colors.white24,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.outfit(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFC8A96E),
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildGlassCard({
    required Widget child,
    EdgeInsets? padding,
    double opacity = 0.1,
  }) {
    return GlassContainer(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: 20,
      opacity: opacity,
      blur: 20,
      borderColor: Colors.white.withValues(alpha: 0.1),
      child: child,
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.outfit(color: Colors.white, fontSize: 16),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white24, size: 20),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'uk':
        return 'Українська';
      case 'ru':
        return 'Русский';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      default:
        return 'English';
    }
  }

  void _showPolicyDialog(BuildContext context, String title) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: GlassContainer(
              borderRadius: 32,
              opacity: 0.15,
              blur: 30,
              padding: const EdgeInsets.all(24),
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Flexible(
                      child: SingleChildScrollView(
                        child: Text(
                          'This is a placeholder for the actual policy text. Specialty Tracker respects your privacy and ensures your coffee-related data is shared only when you explicitly choose to. Your data is encrypted and synced securely via Supabase.',
                          style: TextStyle(color: Colors.white70, height: 1.5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC8A96E),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('GOT IT'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
