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

class AddRecipeDialog extends ConsumerStatefulWidget {
  final String lotId;
  final CustomRecipeDto? existingRecipe;
  final String? initialMethod;

  const AddRecipeDialog({
    super.key,
    required this.lotId,
    this.existingRecipe,
    this.initialMethod,
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
  bool _isOtherGrinder = false;

  // Pour Schedule
  final List<PourControllers> _pourControllers = [];
  final List<FocusNode> _minFocusNodes = List.generate(10, (_) => FocusNode());
  final List<FocusNode> _secFocusNodes = List.generate(10, (_) => FocusNode());
  final List<FocusNode> _durFocusNodes = List.generate(10, (_) => FocusNode());

  @override
  void initState() {
    super.initState();
    final recipe = widget.existingRecipe;

    _method = recipe?.methodKey ?? widget.initialMethod ?? 'v60';
    _recipeType =
        recipe?.recipeType ??
        (_method.toLowerCase() == 'espresso' ? 'espresso' : 'filter');
    _rating = recipe?.rating ?? 0;

    _nameController.text = recipe?.name ?? '';
    _coffeeController.text = recipe?.coffeeGrams.toStringAsFixed(1) ?? '';
    _waterController.text = recipe?.totalWaterMl.toStringAsFixed(1) ?? '';

    // Temperature conversion for display
    final pref = ref.read(preferencesProvider);
    double initialTemp = recipe?.brewTempC ?? 93.0;
    if (pref.tempUnit == TempUnit.fahrenheit) {
      initialTemp = (initialTemp * 9 / 5) + 32;
    }
    _tempController.text = initialTemp.toStringAsFixed(1);

    _grindController.text = recipe?.grindNumber.toString() ?? '';
    _micronsController.text = recipe?.microns?.toString() ?? '';
    _ratioController.text = recipe?.brewRatio?.toStringAsFixed(1) ?? '';

    if (recipe?.extractionTimeSeconds != null) {
      _extractionTimeController.text = _formatSecondsToHMS(
        recipe!.extractionTimeSeconds!,
      );
    } else {
      _extractionTimeController.text = '';
    }

    _notesController.text = recipe?.notes ?? '';

    final initialGrinder = recipe?.grinderName ?? 'Other';
    final presets = [
      'Other',
      'Comandante',
      'EK43',
      'Fellow Ode',
      'Wilfa',
      'Timemore',
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
    String min = '0',
    String sec = '0',
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
    int h = totalSeconds ~/ 3600;
    int m = (totalSeconds % 3600) ~/ 60;
    int s = totalSeconds % 60;
    String hh = h.toString().padLeft(2, '0');
    String mm = m.toString().padLeft(2, '0');
    String ss = s.toString().padLeft(2, '0');
    return '$hh:$mm:$ss';
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
    if (!_formKey.currentState!.validate()) return;
    if (_isOtherGrinder && _customGrinderController.text.isEmpty) return;

    final db = ref.read(databaseProvider);
    final user = ref.read(supabaseProvider).auth.currentUser;
    if (user == null) return;

    final recipe = CustomRecipesCompanion.insert(
      id: Value(widget.existingRecipe?.id ?? const Uuid().v4()),
      userId: user.id,
      lotId: Value(widget.lotId),
      methodKey: _method,
      name: _nameController.text.isEmpty ? 'Recipe' : _nameController.text,
      coffeeGrams: double.tryParse(_coffeeController.text) ?? 15.0,
      totalWaterMl: double.tryParse(_waterController.text) ?? 250.0,
      grindNumber: Value(int.tryParse(_grindController.text) ?? 0),
      comandanteClicks: Value(widget.existingRecipe?.comandanteClicks ?? 0),
      ek43Division: Value(widget.existingRecipe?.ek43Division ?? 0),
      totalPours: Value(_pourControllers.length),
      isSynced: const Value(false),
      recipeType: Value(_recipeType),
      brewRatio: Value(
        double.tryParse(_ratioController.text.replaceAll('1:', '')),
      ),
      grinderName: Value(
        _isOtherGrinder
            ? _customGrinderController.text
            : _grinderNameController.text,
      ),
      microns: Value(int.tryParse(_micronsController.text)),
      extractionTimeSeconds: Value(
        _parseHMSToSeconds(_extractionTimeController.text),
      ),
      pourScheduleJson: Value(
        jsonEncode(
          _pourControllers.map((pc) {
            String mStr = pc.min.text;
            String sStr = pc.sec.text;

            // 1 -> 10 logic
            if (mStr.length == 1 && mStr != '0') mStr = '${mStr}0';
            if (sStr.length == 1 && sStr != '0') sStr = '${sStr}0';

            return {
              'min': int.tryParse(mStr) ?? 0,
              'sec': int.tryParse(sStr) ?? 0,
              'water': double.tryParse(pc.water.text) ?? 0.0,
              'duration': _parseHMSToSeconds(pc.duration.text),
              'notes': pc.notes.text,
            };
          }).toList(),
        ),
      ),
      brewTempC: Value(() {
        final rawTemp = double.tryParse(_tempController.text) ?? 93.0;
        final pref = ref.read(preferencesProvider);
        if (pref.tempUnit == TempUnit.fahrenheit) {
          // Convert back to Celsius for storage
          return (rawTemp - 32) * 5 / 9;
        }
        return rawTemp;
      }()),
      notes: Value(_notesController.text),
      rating: Value(_rating),
      createdAt: Value(widget.existingRecipe?.createdAt ?? DateTime.now()),
      updatedAt: Value(DateTime.now()),
    );

    await db.upsertCustomRecipe(recipe);
    if (mounted) Navigator.pop(context, true);
  }

  int _parseHMSToSeconds(String hms) {
    if (!hms.contains(':')) return int.tryParse(hms) ?? 0;
    final parts = hms.split(':');
    if (parts.length == 3) {
      return (int.tryParse(parts[0]) ?? 0) * 3600 +
          (int.tryParse(parts[1]) ?? 0) * 60 +
          (int.tryParse(parts[2]) ?? 0);
    }
    return int.tryParse(hms.replaceAll(':', '')) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFC8A96E);
    final isUk = LocaleService.currentLocale == 'uk';
    final pref = ref.watch(preferencesProvider);

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero, // Make it full screen
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1B1411), // Deep Coffee Brown
              Color(0xFF0A0908), // Near Black
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
                      isUk ? 'Новий рецепт' : 'New Recipe',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: _save,
                      child: Text(
                        isUk ? 'Зберегти' : 'Save',
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
                        _buildSectionHeader(isUk ? 'Загальне' : 'General'),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _nameController,
                          hint: isUk ? 'Назва рецепту' : 'Recipe Name',
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Text(
                              isUk ? 'Рейтинг:  ' : 'Rating:  ',
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
                              ? (isUk ? 'Кава та вода' : 'Coffee & Water')
                              : (isUk
                                    ? 'Параметри еспресо'
                                    : 'Espresso Parameters'),
                        ),
                        const SizedBox(height: 20),
                        // SECTION: Method Params
                        if (_recipeType == 'filter')
                          _buildFilterParams(isUk, pref)
                        else
                          _buildEspressoParams(isUk, pref),

                        const SizedBox(height: 32),

                        // SECTION: Grinder Settings
                        _buildSectionHeader(
                          isUk ? 'Налаштування помелу' : 'Grinder Settings',
                        ),
                        const SizedBox(height: 20),
                        _buildGrinderSection(isUk, gold),
                        const SizedBox(height: 32),

                        // SECTION: Dynamic (Pour Schedule for Filter)
                        if (_recipeType == 'filter') ...[
                          _buildSectionHeader(
                            isUk ? 'Графік вливань' : 'Pour Schedule',
                          ),
                          const SizedBox(height: 12),
                          if (_recipeType != 'espresso') ...[
                            _buildPourSchedule(isUk, gold),
                            const SizedBox(height: 24),
                          ],
                        ],

                        // SECTION: Notes
                        _buildSectionHeader(isUk ? 'Примітки' : 'Notes'),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _notesController,
                          label: isUk ? 'Примітки' : 'Notes',
                          hint: isUk
                              ? 'Ваші нотатки тут...'
                              : 'Your notes here...',
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
                                  isUk ? 'Скасувати' : 'Cancel',
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
                                  isUk ? 'Зберегти' : 'Save',
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
            counterText: "",
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
              borderSide: BorderSide(width: 1, color: Colors.white10),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterParams(bool isUk, UserPreferences pref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _coffeeController,
                label: isUk ? 'Кава (g)' : 'Coffee (g)',
                hint: '15.0',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _waterController,
                label: isUk ? 'Вода (ml)' : 'Water (ml)',
                hint: '250.0',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _extractionTimeController,
                label: isUk ? 'Час екстракції (хв:сек)' : 'Extraction Time (mm:ss)',
                hint: '00:30',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _TimeMaskFormatter(),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _tempController,
                label: isUk
                    ? 'Температура (${pref.tempUnit == TempUnit.celsius ? '°C' : '°F'})'
                    : 'Brew Temp (${pref.tempUnit == TempUnit.celsius ? '°C' : '°F'})',
                hint: pref.tempUnit == TempUnit.celsius ? '93.0' : '199.4',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _ratioController,
          label: isUk ? 'Співвідношення кави до води' : 'Brew Ratio',
          hint: '1:16.7',
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildEspressoParams(bool isUk, UserPreferences pref) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _coffeeController,
                label: isUk ? 'Кава (g)' : 'Coffee (g)',
                hint: '18.0',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _waterController,
                label: isUk ? 'Вихід (g)' : 'Yield (g)',
                hint: '36.0',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _extractionTimeController,
                label: isUk ? 'Час екстракції (хв:сек)' : 'Extraction Time (mm:ss)',
                hint: '00:30',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  _TimeMaskFormatter(),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildTextField(
                controller: _tempController,
                label: isUk
                    ? 'Температура (${pref.tempUnit == TempUnit.celsius ? '°C' : '°F'})'
                    : 'Brew Temp (${pref.tempUnit == TempUnit.celsius ? '°C' : '°F'})',
                hint: pref.tempUnit == TempUnit.celsius ? '93.0' : '199.4',
                keyboardType: TextInputType.number,
                maxLength: 5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _ratioController,
          label: isUk ? 'Співвідношення кави до води' : 'Brew Ratio',
          hint: '1:2.0',
          readOnly: true,
        ),
      ],
    );
  }

  Widget _buildGrinderSection(bool isUk, Color gold) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isUk ? 'Модель кавомолки' : 'Grinder Model',
          style: GoogleFonts.outfit(color: Colors.white38, fontSize: 11),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: _grinderNameController.text.isNotEmpty
              ? ([
                      'Comandante',
                      'EK43',
                      'Fellow Ode',
                      'Wilfa',
                      'Timemore',
                    ].contains(_grinderNameController.text)
                    ? _grinderNameController.text
                    : 'Other')
              : 'Other',
          dropdownColor: const Color(0xFF1D1B1A),
          style: GoogleFonts.outfit(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          items:
              ['Other', 'Comandante', 'EK43', 'Fellow Ode', 'Wilfa', 'Timemore']
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e == 'Other' && isUk ? 'Інше' : e),
                    ),
                  )
                  .toList(),
          onChanged: (val) => setState(() {
            _grinderNameController.text = val!;
            _isOtherGrinder = val == 'Other';
          }),
        ),
        if (_isOtherGrinder) ...[
          const SizedBox(height: 12),
          _buildTextField(
            controller: _customGrinderController,
            label: isUk ? 'Введіть назву кавомолки' : 'Enter grinder name',
            hint: isUk ? 'Назва кавомолки' : 'Grinder name',
            validator: (val) => val == null || val.isEmpty
                ? (isUk ? 'Обов’язково' : 'Required')
                : null,
          ),
        ],
        const SizedBox(height: 12),
        _buildTextField(
          controller: _grindController,
          label: isUk ? 'Помел' : 'Grind',
          hint: isUk ? 'Налаштування помелу' : 'Grind setting',
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _micronsController,
          label: isUk ? 'Мікрони (µm)' : 'Microns (µm)',
          hint: isUk ? 'Мікрони (µm)' : 'Microns (µm)',
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ],
    );
  }

  Widget _buildPourSchedule(bool isUk, Color gold) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isUk ? 'Графік вливань' : 'Pour Schedule',
              style: GoogleFonts.outfit(
                color: gold,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Row(
              children: [
                Text(
                  isUk ? 'Кількість:' : 'Pours:',
                  style: GoogleFonts.outfit(
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(
                    Icons.remove_circle_outline_rounded,
                    color: gold,
                    size: 20,
                  ),
                  onPressed: () {
                    if (_pourControllers.length > 1) {
                      setState(() => _pourControllers.removeLast().dispose());
                    }
                  },
                ),
                Text(
                  '${_pourControllers.length}',
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle_outline_rounded,
                    color: gold,
                    size: 20,
                  ),
                  onPressed: () {
                    if (_pourControllers.length < 10) {
                      setState(() => _addPourController());
                    }
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(_pourControllers.length, (index) {
          return _buildPourItem(index, isUk, gold);
        }),
      ],
    );
  }

  Widget _buildPourItem(int index, bool isUk, Color gold) {
    final pc = _pourControllers[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isUk ? 'Вливання #${index + 1}' : 'Pour #${index + 1}',
            style: GoogleFonts.outfit(
              color: gold,
              fontWeight: FontWeight.bold,
              fontSize: 11,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: _buildSmallTextFieldWithLabel(
                  label: isUk ? 'Вода (g)' : 'Water (g)',
                  controller: pc.water,
                  hint: '0',
                  maxLength: 5,
                ),
              ),
              const SizedBox(width: 8),
              _buildTimeField(
                label: isUk ? 'Хв' : 'Min',
                controller: pc.min,
                focusNode: _minFocusNodes[index],
                onChanged: (val) {
                  if (val.length >= 2) {
                    if (val.length > 2) {
                      String carry = val.substring(2);
                      String current = val.substring(0, 2);
                      pc.min.text = current;
                      pc.sec.text = carry;
                      _secFocusNodes[index].requestFocus();
                      pc.sec.selection = TextSelection.collapsed(
                        offset: pc.sec.text.length,
                      );
                    } else {
                      _secFocusNodes[index].requestFocus();
                      pc.sec.selection = TextSelection.collapsed(
                        offset: pc.sec.text.length,
                      );
                    }
                  }
                },
              ),
              const SizedBox(width: 8),
              _buildTimeField(
                label: isUk ? 'Сек' : 'Sec',
                controller: pc.sec,
                focusNode: _secFocusNodes[index],
                onChanged: (val) {
                  if (val.length >= 2) {
                    if (val.length > 2) {
                      pc.sec.text = val.substring(0, 2);
                      pc.sec.selection = TextSelection.collapsed(
                        offset: pc.sec.text.length,
                      );
                    }
                    _durFocusNodes[index].requestFocus();
                  }
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 4,
                child: _buildSmallTextFieldWithLabel(
                  label: isUk ? 'Тривалість (ГГ:ХХ:СС)' : 'Duration (HH:MM:SS)',
                  controller: pc.duration,
                  focusNode: _durFocusNodes[index],
                  hint: '00:00:00',
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _TimeMaskFormatter(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSmallTextFieldWithLabel(
            label: isUk ? 'Примітки' : 'Notes',
            controller: pc.notes,
            hint: isUk ? 'Примітки (опціонально)' : 'Notes (optional)',
            isNumber: false,
          ),
        ],
      ),
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
            // Put cursor at end
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
            counterText: "",
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
          width: 50,
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
              LengthLimitingTextInputFormatter(
                4,
              ), // Allow for carry over during typing
            ],
            style: GoogleFonts.outfit(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
    var text = newValue.text.replaceAll(':', '');
    if (text.length > 6) text = text.substring(0, 6);

    var res = '';
    for (var i = 0; i < text.length; i++) {
      res += text[i];
      if ((i == 1 || i == 3) && i != text.length - 1) {
        res += ':';
      }
    }

    return TextEditingValue(
      text: res,
      selection: TextSelection.collapsed(offset: res.length),
    );
  }
}
