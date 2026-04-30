import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import '../../core/database/app_database.dart';
import '../../core/database/dtos.dart';
import '../../core/providers/preferences_provider.dart';
import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/supabase/supabase_provider.dart';
import '../services/toast_service.dart';

part 'add_recipe/recipe_filter_params.dart';
part 'add_recipe/recipe_espresso_params.dart';
part 'add_recipe/recipe_grinder_section.dart';
part 'add_recipe/recipe_pour_schedule.dart';

class AddRecipeDialog extends ConsumerStatefulWidget {
  final String lotId;
  final CustomRecipeDto? existingRecipe;
  final String? initialMethod;
  final RecipeSegment recipeSegment;

  const AddRecipeDialog({
    super.key,
    this.lotId = '',
    this.existingRecipe,
    this.initialMethod,
    this.recipeSegment = RecipeSegment.userLot,
  });

  @override
  ConsumerState<AddRecipeDialog> createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends ConsumerState<AddRecipeDialog> {
  final _formKey = GlobalKey<FormState>();

  // State
  late String _method;
  late String _recipeType; // 'filter' or 'espresso'
  late int _rating;

  // Controllers
  final _nameController = TextEditingController();
  final _coffeeController = TextEditingController();
  final _waterController =
      TextEditingController(); // Also used for Yield in Espresso
  final _tempController = TextEditingController();
  final _grindController = TextEditingController();
  final _micronsController = TextEditingController();
  final _ratioController = TextEditingController();
  final _extractionTimeController = TextEditingController();
  final _notesController = TextEditingController();
  final _grinderNameController = TextEditingController();
  final _customGrinderController = TextEditingController();
  final _customMethodNameController = TextEditingController();
  bool _isOtherGrinder = false;
  bool _isGrinderExpanded = false;
  String? _difficulty;

  // Pour Schedule
  final List<PourControllers> _pourControllers = [];
  final List<FocusNode> _minFocusNodes = List.generate(10, (_) => FocusNode());
  final List<FocusNode> _secFocusNodes = List.generate(10, (_) => FocusNode());
  final List<FocusNode> _durFocusNodes = List.generate(10, (_) => FocusNode());
  void _updateState(VoidCallback callback) => setState(callback);

  @override
  void initState() {
    super.initState();
    final recipe = widget.existingRecipe;

    _method = recipe?.methodKey ?? widget.initialMethod ?? 'v60';
    _recipeType =
        recipe?.recipeType ??
        (_method.toLowerCase() == 'espresso' ? 'espresso' : 'filter');
    _rating = recipe?.rating ?? 0;
    _difficulty = recipe?.difficulty;
    _customMethodNameController.text = recipe?.customMethodName ?? '';

    _nameController.text = recipe?.name ?? '';
    _coffeeController.text = recipe?.coffeeGrams.toStringAsFixed(1) ?? '';
    _waterController.text = recipe?.totalWaterMl.toStringAsFixed(1) ?? '';

    // Temperature conversion for display
    final pref = ref.read(preferencesProvider);
    double initialTemp = recipe?.brewTempC ?? 93.0;
    if (pref.tempUnit == TempUnit.fahrenheit) {
      initialTemp = (initialTemp * 9 / 5) + 32;
    }
    _tempController.text = recipe != null ? initialTemp.toStringAsFixed(1) : '';

    _grindController.text = recipe?.grindNumber.toString() ?? '';
    _micronsController.text = recipe?.microns?.toString() ?? '';
    _ratioController.text = recipe?.brewRatio != null
        ? '1:${recipe!.brewRatio!.toStringAsFixed(1)}'
        : '';

    if (recipe?.extractionTimeSeconds != null) {
      _extractionTimeController.text = _formatSecondsToHMS(
        recipe!.extractionTimeSeconds!,
      );
    } else {
      _extractionTimeController.text = '';
    }

    _notesController.text = recipe?.notes ?? '';

    final initialGrinder = recipe?.grinderName;
    if (initialGrinder == null || initialGrinder.isEmpty) {
      _isOtherGrinder = false;
      _grinderNameController.text = '';
      _isGrinderExpanded = false;
    } else {
      _isGrinderExpanded = true;
      final presets = [
        'Comandante',
        'EK43',
        'Fellow Ode',
        'Wilfa',
        'Timemore',
        'Other',
      ];
      if (presets.contains(initialGrinder)) {
        _isOtherGrinder = initialGrinder == 'Other';
        _grinderNameController.text = initialGrinder;
        _customGrinderController.text = '';
      } else {
        _isOtherGrinder = true;
        _grinderNameController.text = 'Other';
        _customGrinderController.text = initialGrinder;
      }
    }

    // Listeners for Ratio
    _coffeeController.addListener(_updateRatio);
    _waterController.addListener(_updateRatio);

    // Parse Pours
    if (recipe?.pourScheduleJson != null &&
        recipe!.pourScheduleJson.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(recipe.pourScheduleJson);
        for (var p in decoded) {
          _addPourController(
            water: p['water']?.toString() ?? '',
            min: p['min']?.toString() ?? '0',
            sec: p['sec']?.toString() ?? '0',
            duration: _formatSecondsToHMS(
              int.tryParse(p['duration']?.toString() ?? '0') ?? 0,
            ),
            notes: p['notes']?.toString() ?? '',
          );
        }
      } catch (_) {
        _addPourController();
      }
    } else {
      _addPourController();
    }
  }

  void _addPourController({
    String water = '',
    String min = '',
    String sec = '',
    String duration = '',
    String notes = '',
  }) {
    if (_pourControllers.length < 10) {
      _pourControllers.add(
        PourControllers(
          waterVal: water,
          minVal: min,
          secVal: sec,
          durationVal: duration,
          notesVal: notes,
        ),
      );
    }
  }

  void _updateRatio() {
    final coffee = double.tryParse(_coffeeController.text) ?? 0;
    final water = double.tryParse(_waterController.text) ?? 0;
    if (coffee > 0 && water > 0) {
      final ratio = water / coffee;
      _ratioController.text = '1:${ratio.toStringAsFixed(1)}';
    }
  }

  String _formatSecondsToHMS(int totalSeconds) {
    if (totalSeconds <= 0) return '00:00:00';
    final int h = totalSeconds ~/ 3600;
    final int m = (totalSeconds % 3600) ~/ 60;
    final int s = totalSeconds % 60;

    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  int _parseHMSToSeconds(String hms) {
    if (hms.isEmpty) return 0;
    final parts = hms.split(':');
    int hh = 0, mm = 0, ss = 0;

    if (parts.length == 3) {
      hh = int.tryParse(parts[0]) ?? 0;
      mm = int.tryParse(parts[1]) ?? 0;
      ss = int.tryParse(parts[2]) ?? 0;
    } else if (parts.length == 2) {
      mm = int.tryParse(parts[0]) ?? 0;
      ss = int.tryParse(parts[1]) ?? 0;
    } else {
      ss = int.tryParse(parts[0]) ?? 0;
    }

    return hh * 3600 + mm * 60 + ss;
  }

  @override
  void dispose() {
    _coffeeController.removeListener(_updateRatio);
    _waterController.removeListener(_updateRatio);
    _nameController.dispose();
    _coffeeController.dispose();
    _waterController.dispose();
    _tempController.dispose();
    _grindController.dispose();
    _micronsController.dispose();
    _ratioController.dispose();
    _extractionTimeController.dispose();
    _notesController.dispose();
    _grinderNameController.dispose();
    _customGrinderController.dispose();
    _customMethodNameController.dispose();
    for (var pc in _pourControllers) {
      pc.dispose();
    }
    for (var node in _minFocusNodes) {
      node.dispose();
    }
    for (var node in _secFocusNodes) {
      node.dispose();
    }
    for (var node in _durFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      ToastService.showError(context, ref.t('fill_required_fields'));
      return;
    }

    final db = ref.read(databaseProvider);
    final supabase = ref.read(supabaseProvider);
    final user = supabase.auth.currentUser;
    final userId = user?.id ?? 'guest';

    final String recipeId = widget.existingRecipe?.id ?? const Uuid().v4();
    final String recipeName = () {
      String name = _nameController.text.trim();
      if (name.isEmpty) {
        name = ref.t('recipes');
      }
      final methodSuffix = '(${_method.toUpperCase()})';
      if (!name.contains(methodSuffix)) {
        return '$name $methodSuffix';
      }
      return name;
    }();

    final double coffeeGrams = double.tryParse(_coffeeController.text) ?? 15.0;
    final double waterGrams = double.tryParse(_waterController.text) ?? 250.0;
    final int grindNumber = int.tryParse(_grindController.text) ?? 0;
    final String pourScheduleJson = jsonEncode(
      _pourControllers.map((pc) {
        return {
          'min': int.tryParse(pc.min.text) ?? 0,
          'sec': int.tryParse(pc.sec.text) ?? 0,
          'water': double.tryParse(pc.water.text) ?? 0.0,
          'duration': _parseHMSToSeconds(pc.duration.text),
          'notes': pc.notes.text,
        };
      }).toList(),
    );

    final double brewTempC = () {
      final rawTemp = double.tryParse(_tempController.text) ?? 93.0;
      final pref = ref.read(preferencesProvider);
      if (pref.tempUnit == TempUnit.fahrenheit) {
        return (rawTemp - 32) * 5 / 9;
      }
      return rawTemp;
    }();

    final String grinderName = _isOtherGrinder
        ? _customGrinderController.text
        : _grinderNameController.text;

    final createdAt = widget.existingRecipe?.createdAt ?? DateTime.now();
    final updatedAt = DateTime.now();

    try {
      // Local Database Upsert
      switch (widget.recipeSegment) {
        case RecipeSegment.userLot:
          await db.upsertUserLotRecipe(UserLotRecipesCompanion(
            id: Value(recipeId),
            userId: Value(userId),
            lotId: Value(widget.lotId.isEmpty ? null : widget.lotId),
            methodKey: Value(_method),
            name: Value(recipeName),
            coffeeGrams: Value(coffeeGrams),
            totalWaterMl: Value(waterGrams),
            grindNumber: Value(grindNumber),
            comandanteClicks: Value(grinderName == 'Comandante' ? grindNumber : 0),
            ek43Division: Value(grinderName == 'EK43' ? grindNumber : 0),
            totalPours: Value(_pourControllers.length),
            isSynced: const Value(false),
            recipeType: Value(_recipeType),
            brewRatio: Value(double.tryParse(_ratioController.text.replaceAll('1:', ''))),
            grinderName: Value(grinderName),
            microns: Value(int.tryParse(_micronsController.text)),
            extractionTimeSeconds: Value(_parseHMSToSeconds(_extractionTimeController.text)),
            difficulty: Value(_difficulty),
            customMethodName: Value(_customMethodNameController.text.trim()),
            pourScheduleJson: Value(pourScheduleJson),
            brewTempC: Value(brewTempC),
            notes: Value(_notesController.text.trim()),
            contentHtml: Value(widget.existingRecipe?.contentHtml),
            rating: Value(_rating),
            createdAt: Value(createdAt),
            updatedAt: Value(updatedAt),
          ));
          break;

        case RecipeSegment.encyclopedia:
          await db.upsertEncyclopediaRecipe(EncyclopediaRecipesCompanion(
            id: Value(recipeId),
            userId: Value(userId),
            beanId: Value(int.tryParse(widget.lotId)),
            methodKey: Value(_method),
            name: Value(recipeName),
            coffeeGrams: Value(coffeeGrams),
            totalWaterMl: Value(waterGrams),
            grindNumber: Value(grindNumber),
            comandanteClicks: Value(grinderName == 'Comandante' ? grindNumber : 0),
            ek43Division: Value(grinderName == 'EK43' ? grindNumber : 0),
            totalPours: Value(_pourControllers.length),
            isSynced: const Value(false),
            recipeType: Value(_recipeType),
            brewRatio: Value(double.tryParse(_ratioController.text.replaceAll('1:', ''))),
            grinderName: Value(grinderName),
            microns: Value(int.tryParse(_micronsController.text)),
            extractionTimeSeconds: Value(_parseHMSToSeconds(_extractionTimeController.text)),
            difficulty: Value(_difficulty),
            customMethodName: Value(_customMethodNameController.text.trim()),
            pourScheduleJson: Value(pourScheduleJson),
            brewTempC: Value(brewTempC),
            notes: Value(_notesController.text.trim()),
            contentHtml: Value(widget.existingRecipe?.contentHtml),
            rating: Value(_rating),
            createdAt: Value(createdAt),
            updatedAt: Value(updatedAt),
          ));
          break;

        case RecipeSegment.alternative:
          await db.upsertAlternativeRecipe(AlternativeRecipesCompanion(
            id: Value(recipeId),
            userId: Value(userId),
            methodKey: Value(_method),
            name: Value(recipeName),
            coffeeGrams: Value(coffeeGrams),
            totalWaterMl: Value(waterGrams),
            grindNumber: Value(grindNumber),
            comandanteClicks: Value(grinderName == 'Comandante' ? grindNumber : 0),
            ek43Division: Value(grinderName == 'EK43' ? grindNumber : 0),
            totalPours: Value(_pourControllers.length),
            isSynced: const Value(false),
            recipeType: Value(_recipeType),
            brewRatio: Value(double.tryParse(_ratioController.text.replaceAll('1:', ''))),
            grinderName: Value(grinderName),
            microns: Value(int.tryParse(_micronsController.text)),
            extractionTimeSeconds: Value(_parseHMSToSeconds(_extractionTimeController.text)),
            difficulty: Value(_difficulty),
            customMethodName: Value(_customMethodNameController.text.trim()),
            pourScheduleJson: Value(pourScheduleJson),
            brewTempC: Value(brewTempC),
            notes: Value(_notesController.text.trim()),
            contentHtml: Value(widget.existingRecipe?.contentHtml),
            rating: Value(_rating),
            createdAt: Value(createdAt),
            updatedAt: Value(updatedAt),
          ));
          break;
      }

      debugPrint('RecipeDialog: Local save successful');

      if (!mounted) return;
      ToastService.showSuccess(context, ref.t('toast_recipe_saved'));
      Navigator.pop(context, true);

      // Cloud Sync
      if (user != null) {
        try {
          final String cloudTable = switch (widget.recipeSegment) {
            RecipeSegment.userLot => 'user_lot_recipes',
            RecipeSegment.encyclopedia => 'user_encyclopedia_recipes',
            RecipeSegment.alternative => 'user_alternative_recipes',
          };

          dynamic safeJson(String source) {
            try {
              if (source.isEmpty || source == '[]' || source == '{}') return source.startsWith('[') ? [] : {};
              return jsonDecode(source);
            } catch (_) {
              return source.startsWith('[') ? [] : {};
            }
          }

          final Map<String, dynamic> cloudData = {
            'id': recipeId,
            'user_id': userId,
            'method_key': _method,
            'name': recipeName,
            'coffee_grams': coffeeGrams,
            'total_water_ml': waterGrams,
            'grind_number': grindNumber,
            'comandante_clicks': grinderName == 'Comandante' ? grindNumber : 0,
            'ek43_division': grinderName == 'EK43' ? grindNumber : 0,
            'total_pours': _pourControllers.length,
            'pour_schedule_json': safeJson(pourScheduleJson),
            'brew_temp_c': brewTempC,
            'notes': _notesController.text.trim(),
            'rating': _rating,
            'created_at': createdAt.toIso8601String(),
            'updated_at': updatedAt.toIso8601String(),
            'recipe_type': _recipeType,
            'custom_method_name': _customMethodNameController.text.trim(),
          };

          if (widget.recipeSegment == RecipeSegment.userLot) {
            cloudData['lot_id'] = widget.lotId.isEmpty ? null : widget.lotId;
          } else if (widget.recipeSegment == RecipeSegment.encyclopedia) {
            cloudData['bean_id'] = int.tryParse(widget.lotId);
          }

          await supabase.from(cloudTable).upsert(cloudData);

          // Mark as synced locally
          switch (widget.recipeSegment) {
            case RecipeSegment.userLot:
              await db.upsertUserLotRecipe(UserLotRecipesCompanion(
                id: Value(recipeId),
                isSynced: const Value(true),
              ));
              break;
            case RecipeSegment.encyclopedia:
              await db.upsertEncyclopediaRecipe(EncyclopediaRecipesCompanion(
                id: Value(recipeId),
                isSynced: const Value(true),
              ));
              break;
            case RecipeSegment.alternative:
              await db.upsertAlternativeRecipe(AlternativeRecipesCompanion(
                id: Value(recipeId),
                isSynced: const Value(true),
              ));
              break;
          }
          
          // Trigger immediate global sync
          ref.read(syncServiceProvider).syncAll();
        } catch (e) {
          debugPrint('RecipeDialog: Cloud sync error: $e');
        }
      }

      // Trigger global push for immediate persistence of all related objects
      ref.read(syncServiceProvider).pushLocalUserContent();
    } catch (e) {
      debugPrint('RecipeDialog: Local save error: $e');
      if (mounted) {
        ToastService.showError(context, ref.t('error_saving_recipe'));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFC8A96E);
    final pref = ref.watch(preferencesProvider);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero, // Make it full screen
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black, // Pure Black (Top)
              Color(0xFF121212), // Dark Surface (Bottom)
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Text(
                      ref.t('new_recipe'),
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: _save,
                      child: Text(
                        ref.t('save'),
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: gold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SECTION: Загальне
                        _buildSectionHeader(ref.t('general')),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _nameController,
                          hint: ref.t('recipe_name'),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _customMethodNameController,
                          hint: 'Назва способу (напр. Hario Switch)',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              ref.t('rating_label'),
                              style: GoogleFonts.outfit(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => _rating = index + 1),
                                  child: Icon(
                                    index < _rating
                                        ? Icons.star_rounded
                                        : Icons.star_border_rounded,
                                    color: gold,
                                    size: 32,
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),

                        // SECTION: Кава та вода (Dynamic based on Type)
                        _buildSectionHeader(
                          _recipeType == 'filter'
                              ? ref.t('coffee_and_water')
                              : ref.t('espresso_parameters'),
                        ),
                        const SizedBox(height: 20),
                        // SECTION: Method Params
                        if (_recipeType == 'filter')
                          _buildFilterParams(ref, pref)
                        else
                          _buildEspressoParams(ref, pref),

                        const SizedBox(height: 32),

                        // SECTION: Grinder Settings
                        _buildSectionHeader(ref.t('grinder_settings')),
                        const SizedBox(height: 20),
                        _buildGrinderSection(ref, gold),
                        const SizedBox(height: 32),

                        // SECTION: Dynamic (Pour Schedule for Filter)
                        if (_recipeType == 'filter') ...[
                          _buildSectionHeader(ref.t('pour_schedule')),
                          const SizedBox(height: 12),
                          if (_recipeType != 'espresso') ...[
                            _buildPourSchedule(ref, gold),
                            const SizedBox(height: 24),
                          ],
                        ],

                        // SECTION: Difficulty
                        _buildSectionHeader(ref.t('difficulty')),
                        const SizedBox(height: 16),
                        _buildDifficultySelector(ref),
                        const SizedBox(height: 32),



                        // SECTION: Notes
                        _buildSectionHeader(ref.t('notes_hint')),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _notesController,
                          label: ref.t('notes_hint'),
                          hint: ref.t('notes_placeholder'),
                          maxLines: 4,
                        ),
                        const SizedBox(height: 32),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                child: Text(
                                  ref.t('cancel'),
                                  style: GoogleFonts.outfit(
                                    color: Colors.white38,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _save,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: gold,
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  ref.t('save'),
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFC8A96E),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFC8A96E).withValues(alpha: 0.3),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDifficultySelector(WidgetRef ref) {
    final options = [
      {'key': 'beginner', 'stars': 1, 'color': const Color(0xFF00FF88)},
      {'key': 'intermediate', 'stars': 2, 'color': const Color(0xFFFFEE00)},
      {'key': 'advanced', 'stars': 3, 'color': const Color(0xFFFF3333)},
      {'key': 'expert', 'stars': 4, 'color': const Color(0xFFFF3366)},
      {'key': 'master', 'stars': 5, 'color': const Color(0xFFCC00FF)},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final key = opt['key'] as String;
        final isSelected = _difficulty == key;
        final color = opt['color'] as Color;

        return InkWell(
          onTap: () => setState(() => _difficulty = key),
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOutCubic,
            width: (MediaQuery.of(context).size.width - 100) / 3,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? color.withValues(alpha: 0.5)
                    : Colors.white.withValues(alpha: 0.05),
                width: 1.5,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.2),
                        blurRadius: 15,
                        spreadRadius: -5,
                      ),
                    ]
                  : null,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    final active = i < (opt['stars'] as int);
                    return Icon(
                      Icons.star_rounded,
                      color: active
                          ? color
                          : Colors.white.withValues(alpha: 0.05),
                      size: 14,
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Text(
                  ref.t('difficulty_$key'),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w900 : FontWeight.w600,
                    color: isSelected ? color : Colors.white38,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hint,
    String? label,
    bool readOnly = false,
    int? maxLines = 1,
    TextInputType? keyboardType,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 4),
            child: Text(
              label,
              style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
            ),
          ),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          readOnly: readOnly,
          validator: validator,
          enableInteractiveSelection: false,
          maxLength: maxLength,
          inputFormatters:
              inputFormatters ??
              [
                if (keyboardType == TextInputType.number)
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
          onTap: () {
            controller.selection = TextSelection.collapsed(
              offset: controller.text.length,
            );
          },
          onChanged: (val) {
            if (controller == _coffeeController ||
                controller == _waterController) {
              _updateRatio();
            }
          },
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(color: Colors.white24, fontSize: 15),
            counterText: '',
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(width: 1, color: Colors.white10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallTextFieldWithLabel({
    required String label,
    required String hint,
    required TextEditingController controller,
    Function(String)? onChanged,
    bool isNumber = true,
    int? maxLength,
    bool readOnly = false,
    FocusNode? focusNode,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10),
          ),
        ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          focusNode: focusNode,
          readOnly: readOnly,
          enableInteractiveSelection: false,
          keyboardType: isNumber
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          onTap: () {
            controller.selection = TextSelection.collapsed(
              offset: controller.text.length,
            );
          },
          inputFormatters:
              inputFormatters ??
              [
                if (isNumber)
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                if (maxLength != null)
                  LengthLimitingTextInputFormatter(maxLength),
              ],
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
            counterText: '',
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField({
    required String label,
    required TextEditingController controller,
    Function(String)? onChanged,
    FocusNode? focusNode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 4),
          child: Text(
            label,
            style: GoogleFonts.outfit(color: Colors.white38, fontSize: 10),
          ),
        ),
        SizedBox(
          width: 55,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            focusNode: focusNode,
            enableInteractiveSelection: false,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onTap: () {
              controller.selection = TextSelection.collapsed(
                offset: controller.text.length,
              );
            },
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
              _MaxIntFormatter(59),
            ],
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: GoogleFonts.outfit(
                color: Colors.white24,
                fontSize: 13,
              ),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
              ), // Same vertical padding as other fields
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PourControllers {
  final TextEditingController water;
  final TextEditingController min;
  final TextEditingController sec;
  final TextEditingController duration;
  final TextEditingController notes;

  PourControllers({
    required String waterVal,
    required String minVal,
    required String secVal,
    required String durationVal,
    required String notesVal,
  }) : water = TextEditingController(text: waterVal),
       min = TextEditingController(text: minVal),
       sec = TextEditingController(text: secVal),
       duration = TextEditingController(text: durationVal),
       notes = TextEditingController(text: notesVal);

  void dispose() {
    water.dispose();
    min.dispose();
    sec.dispose();
    duration.dispose();
    notes.dispose();
  }
}

class _TimeMaskFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Get only digits
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // 2. Limit to 6 digits (HHMMSS)
    if (digits.length > 6) {
      digits = digits.substring(0, 6);
    }

    // 3. Process digits and validate segments (MM <= 59, SS <= 59)
    String formatted = '';
    for (int i = 0; i < digits.length; i++) {
      String digit = digits[i];

      // Minutes first digit (index 2) max 5
      if (i == 2 && int.parse(digit) > 5) {
        digit = '5';
      }
      // Seconds first digit (index 4) max 5
      if (i == 4 && int.parse(digit) > 5) {
        digit = '5';
      }

      formatted += digit;

      // Add colons at positions 2 and 4
      if ((i == 1 || i == 3) && i != digits.length - 1) {
        formatted += ':';
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

class _MaxIntFormatter extends TextInputFormatter {
  final int max;
  _MaxIntFormatter(this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;
    final intValue = int.tryParse(newValue.text);
    if (intValue == null) return oldValue;
    if (intValue > max) {
      return TextEditingValue(
        text: max.toString(),
        selection: TextSelection.collapsed(offset: max.toString().length),
      );
    }
    return newValue;
  }
}

// _LtoRTimeMaskFormatter was merged into _TimeMaskFormatter
