import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import '../../core/database/app_database.dart';
import '../../core/database/dtos.dart';
import '../../core/supabase/supabase_provider.dart';
import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';

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
  late final TextEditingController _nameController;
  late final TextEditingController _coffeeController;
  late final TextEditingController _waterController; // Also used for Yield in Espresso
  late final TextEditingController _tempController;
  late final TextEditingController _grindController;
  late final TextEditingController _micronsController;
  late final TextEditingController _ratioController;
  late final TextEditingController _extractionTimeController;
  late final TextEditingController _notesController;
  late final TextEditingController _grinderNameController;

  // Pour Schedule
  List<Map<String, dynamic>> _pours = [];

  @override
  void initState() {
    super.initState();
    final recipe = widget.existingRecipe;
    
    _method = recipe?.methodKey ?? widget.initialMethod ?? 'v60';
    _recipeType = recipe?.recipeType ?? (_method.toLowerCase() == 'espresso' ? 'espresso' : 'filter');
    _rating = recipe?.rating ?? 0;
    
    _nameController = TextEditingController(text: recipe?.name ?? '');
    _coffeeController = TextEditingController(text: recipe?.coffeeGrams.toStringAsFixed(1) ?? '18.0');
    _waterController = TextEditingController(text: recipe?.totalWaterMl.toStringAsFixed(1) ?? '250.0');
    _tempController = TextEditingController(text: recipe?.brewTempC.toStringAsFixed(1) ?? '93.0');
    _grindController = TextEditingController(text: recipe?.grindNumber.toString() ?? '');
    _micronsController = TextEditingController(text: recipe?.microns?.toString() ?? '');
    _ratioController = TextEditingController(text: recipe?.brewRatio?.toStringAsFixed(1) ?? '1:2.0');
    _extractionTimeController = TextEditingController(text: recipe?.extractionTimeSeconds?.toString() ?? '30');
    _notesController = TextEditingController(text: recipe?.notes ?? '');
    _grinderNameController = TextEditingController(text: recipe?.grinderName ?? 'Other');

    // Parse Pours
    if (recipe?.pourScheduleJson != null && recipe!.pourScheduleJson.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(recipe.pourScheduleJson);
        _pours = decoded.map((e) => Map<String, dynamic>.from(e)).toList();
      } catch (_) {
        _pours = [{'water': 50, 'min': 0, 'sec': 0, 'duration': 30, 'notes': ''}];
      }
    } else {
      _pours = [{'water': 50, 'min': 0, 'sec': 0, 'duration': 30, 'notes': ''}];
    }
  }

  @override
  void dispose() {
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
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

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
      totalPours: Value(_pours.length),
      pourScheduleJson: Value(jsonEncode(_pours)),
      brewTempC: Value(double.tryParse(_tempController.text) ?? 93.0),
      notes: Value(_notesController.text),
      rating: Value(_rating),
      createdAt: Value(widget.existingRecipe?.createdAt ?? DateTime.now()),
      updatedAt: Value(DateTime.now()),
      isSynced: const Value(false),
      recipeType: Value(_recipeType),
      brewRatio: Value(double.tryParse(_ratioController.text.replaceAll('1:', ''))),
      grinderName: Value(_grinderNameController.text),
      microns: Value(int.tryParse(_micronsController.text)),
      extractionTimeSeconds: Value(int.tryParse(_extractionTimeController.text)),
    );

    await db.upsertCustomRecipe(recipe);
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final gold = const Color(0xFFC8A96E);
    final isUk = LocaleService.currentLocale == 'uk';

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero, // Make it full screen
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFF0A0908),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
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
                        'Save',
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
                              'Rating:  ',
                              style: GoogleFonts.outfit(color: Colors.white70, fontSize: 16),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () => setState(() => _rating = index + 1),
                                  child: Icon(
                                    index < _rating ? Icons.star_rounded : Icons.star_border_rounded,
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
                        _buildSectionHeader(_recipeType == 'filter' 
                          ? (isUk ? 'Кава та вода' : 'Coffee & Water')
                          : (isUk ? 'Параметри еспресо' : 'Espresso Parameters')
                        ),
                        const SizedBox(height: 20),
                        
                        if (_recipeType == 'filter') _buildFilterParams(isUk)
                        else _buildEspressoParams(isUk),
                        
                        const SizedBox(height: 32),

                        // SECTION: Grinder Settings
                        _buildSectionHeader(isUk ? 'Grinder Settings' : 'Grinder Settings'),
                        const SizedBox(height: 20),
                        _buildGrinderSection(isUk, gold),
                        const SizedBox(height: 32),

                        // SECTION: Dynamic (Pour Schedule for Filter)
                        if (_recipeType == 'filter') ...[
                          _buildSectionHeader(isUk ? 'Графік вливань' : 'Pour Schedule'),
                          const SizedBox(height: 20),
                          _buildPourSchedule(isUk, gold),
                          const SizedBox(height: 32),
                        ],

                        // SECTION: Notes
                        _buildSectionHeader(isUk ? 'notes' : 'notes'),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: _notesController,
                          hint: isUk ? 'Примітки' : 'Notes',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 40),

                        // SAVE BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: gold,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                            ),
                            child: Text(
                              'Save Recipe',
                              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
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
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
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
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.outfit(color: Colors.white24, fontSize: 15),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterParams(bool isUk) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(controller: _coffeeController, hint: isUk ? 'Кава (g)' : 'Coffee (g)', keyboardType: TextInputType.number)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(controller: _waterController, hint: isUk ? 'Загальна кількість ...' : 'Total water (ml)', keyboardType: TextInputType.number)),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: _tempController,
          label: isUk ? 'Brew Temperature (°C)' : 'Brew Temperature (°C)',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildEspressoParams(bool isUk) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(controller: _coffeeController, label: isUk ? 'Кава (g)' : 'Coffee (g)', keyboardType: TextInputType.number)),
            const SizedBox(width: 12),
            Expanded(child: _buildTextField(controller: _waterController, label: isUk ? 'Вихід (Yield) (g/ml)' : 'Yield (g/ml)', keyboardType: TextInputType.number)),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(controller: _extractionTimeController, label: isUk ? 'Час екстракції (s)' : 'Extraction Time (s)', keyboardType: TextInputType.number),
        const SizedBox(height: 12),
        _buildTextField(controller: _tempController, label: isUk ? 'Brew Temperature (°C)' : 'Brew Temperature (°C)', keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildGrinderSection(bool isUk, Color gold) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          initialValue: _grinderNameController.text,
          dropdownColor: const Color(0xFF1D1B1A),
          style: GoogleFonts.outfit(color: Colors.white),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
          items: ['Other', 'Comandante', 'EK43', 'Fellow Ode', 'Wilfa', 'Timemore']
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (val) => setState(() => _grinderNameController.text = val!),
        ),
        const SizedBox(height: 12),
        _buildTextField(controller: _grindController, hint: isUk ? 'Grind Settings' : 'Grind Settings'),
        const SizedBox(height: 12),
        _buildTextField(controller: _micronsController, hint: isUk ? 'Microns (µm)' : 'Microns (µm)', keyboardType: TextInputType.number),
        if (_recipeType == 'espresso') ...[
          const SizedBox(height: 12),
          _buildTextField(controller: _ratioController, label: isUk ? 'Brew Ratio' : 'Brew Ratio'),
        ],
      ],
    );
  }

  Widget _buildPourSchedule(bool isUk, Color gold) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(isUk ? 'Кількість вливань:' : 'Number of pours:', style: GoogleFonts.outfit(color: Colors.white, fontSize: 15)),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle_outline_rounded, color: gold),
                  onPressed: () {
                    if (_pours.length > 1) {
                      setState(() => _pours.removeLast());
                    }
                  },
                ),
                Text('${_pours.length}', style: GoogleFonts.outfit(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.add_circle_outline_rounded, color: gold),
                  onPressed: () {
                    setState(() => _pours.add({'water': 50, 'min': 0, 'sec': 0, 'duration': 30, 'notes': ''}));
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...List.generate(_pours.length, (index) {
          return _buildPourItem(index, isUk, gold);
        }),
      ],
    );
  }

  Widget _buildPourItem(int index, bool isUk, Color gold) {
    final pour = _pours[index];
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
            'Pour #${index + 1}',
            style: GoogleFonts.outfit(color: gold, fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildSmallTextField(
                  initialValue: pour['water'].toString(),
                  hint: 'water (g)',
                  onChanged: (val) => pour['water'] = double.tryParse(val) ?? 0,
                ),
              ),
              const SizedBox(width: 8),
              _buildTimeField(
                label: 'Min',
                initialValue: pour['min'].toString(),
                onChanged: (val) => pour['min'] = int.tryParse(val) ?? 0,
              ),
              const SizedBox(width: 8),
              _buildTimeField(
                label: 'Sec',
                initialValue: pour['sec'].toString(),
                onChanged: (val) => pour['sec'] = int.tryParse(val) ?? 0,
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: _buildSmallTextField(
                  initialValue: pour['duration'].toString(),
                  hint: 'duration (...',
                  onChanged: (val) => pour['duration'] = int.tryParse(val) ?? 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSmallTextField(
            initialValue: pour['notes'] ?? '',
            hint: 'Notes (optional)',
            onChanged: (val) => pour['notes'] = val,
          ),
        ],
      ),
    );
  }

  Widget _buildSmallTextField({required String hint, required String initialValue, required Function(String) onChanged}) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.outfit(color: Colors.white24, fontSize: 11),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildTimeField({required String label, required String initialValue, required Function(String) onChanged}) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.outfit(color: Colors.white38, fontSize: 9)),
        const SizedBox(height: 4),
        SizedBox(
          width: 45,
          child: TextFormField(
            initialValue: initialValue,
            onChanged: onChanged,
            textAlign: TextAlign.center,
            style: GoogleFonts.outfit(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            ),
          ),
        ),
      ],
    );
  }
}
