import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/widgets/add_recipe_dialog.dart';

import '../../../core/database/database_provider.dart';
import '../../../core/database/dtos.dart';
import '../../../shared/widgets/glass_container.dart';
import '../custom_recipe_timer_screen.dart';
import '../custom_recipe_list.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/services/toast_service.dart';

class CustomRecipeCard extends StatelessWidget {
  final CustomRecipeDto recipe;
  final String methodKey;
  final WidgetRef ref;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback? onTap;
  
  const CustomRecipeCard({
    super.key,
    required this.recipe,
    required this.methodKey,
    required this.ref,
    this.isSelectionMode = false,
    this.isSelected = false,
    this.onTap,
  });

  List<Map<String, dynamic>> get _pours {
    try {
      return (jsonDecode(recipe.pourScheduleJson) as List)
          .cast<Map<String, dynamic>>();
    } catch (_) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final pours = _pours;

    return GlassContainer(
      padding: const EdgeInsets.all(0),
      borderColor: isSelected 
        ? const Color(0xFFC8A96E) 
        : Colors.white.withValues(alpha: 0.1),
      child: InkWell(
        onTap: isSelectionMode ? onTap : null,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 8, 4),
              child: Row(
                children: [
                  if (isSelectionMode) ...[
                    Icon(
                      isSelected 
                        ? Icons.check_circle_rounded 
                        : Icons.radio_button_unchecked_rounded,
                      color: isSelected ? const Color(0xFFC8A96E) : Colors.white24,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8A96E).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      recipe.recipeType == 'espresso' 
                        ? Icons.coffee_maker_rounded 
                        : Icons.coffee_rounded,
                      color: const Color(0xFFC8A96E),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      recipe.name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Rating stars
                  if (recipe.rating > 0 && !isSelectionMode)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          recipe.rating,
                          (_) => const Icon(
                            Icons.star_rounded,
                            color: Color(0xFFC8A96E),
                            size: 14,
                          ),
                        ),
                      ),
                    ),
                  // Actions
                  if (!isSelectionMode)
                    IconButton(
                      icon: const Icon(
                        Icons.more_horiz_rounded,
                        color: Colors.white38,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => GlassContainer(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            borderRadius: 32,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(
                                    Icons.edit_rounded,
                                    color: Colors.white70,
                                  ),
                                  title: const Text(
                                    'Edit Recipe',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      final result = await showDialog<bool>(
                                        context: context,
                                        builder: (context) => AddRecipeDialog(
                                          lotId: recipe.lotId ?? '',
                                          existingRecipe: recipe,
                                        ),
                                      );
                                      if (result == true) {
                                        ref.invalidate(customRecipesForMethodProvider(methodKey));
                                      }
                                    },
                                  ),
                                ListTile(
                                  leading: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  title: const Text(
                                    'Delete Recipe',
                                    style: TextStyle(color: Colors.redAccent),
                                  ),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    final db = ref.read(databaseProvider);
                                    await db.deleteCustomRecipe(recipe.id);
                                    if (context.mounted) {
                                      ToastService.showInfo(
                                        context, 
                                        context.t('toast_recipe_deleted')
                                      );
                                    }
                                    ref.invalidate(
                                      customRecipesForMethodProvider(methodKey),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          // Key stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _Tag(
                  Icons.scale_rounded,
                  '${recipe.coffeeGrams.toStringAsFixed(1)}g',
                ),
                _Tag(
                  Icons.water_drop_rounded,
                  '${recipe.totalWaterMl.toStringAsFixed(0)}ml',
                ),
                if (recipe.brewTempC > 0)
                  _Tag(
                    Icons.thermostat_rounded,
                    '${recipe.brewTempC.toInt()}°C',
                  ),
                if (recipe.brewRatio != null && recipe.brewRatio! > 0)
                  _Tag(
                    Icons.balance_rounded,
                    '1:${recipe.brewRatio!.toStringAsFixed(1)}',
                  ),
                // Grinder display logic
                if (recipe.grinderName != 'Other' && recipe.grinderName != null)
                  _Tag(
                    Icons.settings_input_component_rounded,
                    '${recipe.grinderName}: ${_getGrinderValue()}',
                  )
                else if (recipe.grindNumber > 0)
                  _Tag(
                    Icons.settings_input_component_rounded,
                    'Grind ${recipe.grindNumber}',
                  ),
                if (recipe.microns != null && recipe.microns! > 0)
                  _Tag(
                    Icons.height_rounded, 
                    '${recipe.microns}μm',
                  ),
                if (recipe.totalPours > 1 && recipe.recipeType != 'espresso')
                  _Tag(Icons.opacity_rounded, '${recipe.totalPours} pours'),
              ],
            ),
          ),

          if (pours.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.white12, height: 24),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: pours.map<Widget>((pour) {
                  final n = pour['pourNumber'] ?? '–';
                  final ml = pour['waterMl'];
                  final at = pour['atMinute'];
                  return Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pour #$n',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: const Color(0xFFC8A96E),
                          ),
                        ),
                        const SizedBox(height: 2),
                        if (ml != null)
                          Text(
                            '${ml}ml',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        if (at != null)
                          Text(
                            'at ${at}min',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.white38,
                            ),
                          ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],

          // Start Button
          if (pours.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => CustomRecipeTimerScreen(recipe: recipe),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC8A96E),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.timer_outlined, size: 20),
                      const SizedBox(width: 10),
                      Text(
                        'START BREWING',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
        ),
      ),
    );
  }

  String _getGrinderValue() {
    if (recipe.grinderName == 'EK43') return recipe.ek43Division.toString();
    if (recipe.grinderName != null && recipe.grinderName!.contains('Comandante')) {
      return recipe.comandanteClicks.toString();
    }
    return recipe.grindNumber.toString();
  }
}

class _Tag extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Tag(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFFC8A96E)),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
