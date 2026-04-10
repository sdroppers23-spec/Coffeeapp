import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/providers/settings_provider.dart';
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
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Налаштування', // matching screenshot directly
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // МОВА
              _buildSectionTitle('МОВА'),
              _buildCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.language, color: Colors.white54, size: 22),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _getLanguageName(ref.watch(localeProvider)),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // In a real app this would open a dropdown or language sheet
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _getLanguageName(ref.watch(localeProvider)),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Color(0xFFC8A96E),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ВІБРАЦІЯ
              _buildSectionTitle('ВІБРАЦІЯ'),
              _buildCard(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Тактильний відгук',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Легка вібрація при натисканні та\nутриманні',
                              style: GoogleFonts.poppins(
                                color: Colors.white38,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch.adaptive(
                        value: ref.watch(settingsProvider),
                        activeColor: const Color(0xFF2C221D),
                        activeTrackColor: const Color(0xFFC8A96E).withValues(alpha: 0.3),
                        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) {
                            return const Color(0xFFC8A96E);
                          }
                          return Colors.grey;
                        }),
                        onChanged: (val) {
                          ref.read(settingsProvider.notifier).toggleVibration(val);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // TEST HAPTIC
              GestureDetector(
                onTap: () => ref.read(settingsProvider.notifier).triggerVibrate(),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.vibration_rounded,
                        color: Color(0xFFC8A96E),
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'TEST HAPTIC',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFFC8A96E),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // ЮРИДИЧНА ІНФОРМАЦІЯ
              _buildSectionTitle('ЮРИДИЧНА ІНФОРМАЦІЯ'),
              _buildCard(
                child: Column(
                  children: [
                    _buildListItem(
                      icon: Icons.security_rounded,
                      title: 'Політика конфіденційності',
                      onTap: () {},
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    _buildListItem(
                      icon: Icons.insert_drive_file_outlined,
                      title: 'Умови використання',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ПІДТРИМКА
              _buildSectionTitle('ПІДТРИМКА'),
              _buildCard(
                child: Column(
                  children: [
                    _buildListItem(
                      icon: Icons.mail_outline_rounded,
                      title: 'Зв\'язатися з нами',
                      onTap: () {},
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    _buildListItem(
                      icon: Icons.star_border_rounded,
                      title: 'Оцінити додаток',
                      onTap: () {},
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFC8A96E),
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1815),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: Colors.white54, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              ),
            ),
            const Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 20),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    if (code == 'uk') return 'Українська';
    if (code == 'ru') return 'Русский';
    return 'Українська'; // default fallback for visual exactness to screenshot
  }
}
