import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import '../../../shared/widgets/add_recipe_dialog.dart';
import '../../../core/providers/settings_provider.dart';
import '../../../core/l10n/app_localizations.dart';

class DebugContent extends ConsumerWidget {
  const DebugContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUk = ref.watch(localeProvider) == 'uk';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isUk ? 'ТЕСТУВАННЯ ТА РОЗРОБКА' : 'TESTING & DEVELOPMENT',
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFC8A96E).withValues(alpha: 0.6),
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildGlassRecipeTile(
                context: context,
                ref: ref,
                title: isUk ? 'Еспресо' : 'Espresso',
                subtitle: isUk ? 'Швидкий рецепт' : 'Quick recipe',
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
                ref: ref,
                title: isUk ? 'Фільтр' : 'Filter',
                subtitle: isUk ? 'В60, Chemex...' : 'V60, Chemex...',
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
        ],
      ),
    );
  }

  Widget _buildGlassRecipeTile({
    required BuildContext context,
    required WidgetRef ref,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Expanded(
      child: GestureDetector(
        onTap: () {
          ref.read(settingsProvider.notifier).triggerHaptic();
          onTap();
        },
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
