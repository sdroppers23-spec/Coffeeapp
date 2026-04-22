import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart' hide Column;
import '../../core/database/app_database.dart';
import '../../core/supabase/supabase_provider.dart';
import '../widgets/glass_container.dart';
import '../../core/database/database_provider.dart';
import '../../core/l10n/app_localizations.dart';
import '../../core/database/dtos.dart';
import '../widgets/sensory_radar_chart.dart';
import '../../core/providers/design_theme_provider.dart';

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
  late String _method;
  late String _recipeType; // 'filter' or 'espresso'
  
  final _nameController = TextEditingController();
  final _coffeeController = TextEditingController();
  final _waterController = TextEditingController();
  final _tempController = TextEditingController();
  final _grindController = TextEditingController();
  final _notesController = TextEditingController();
  
  // Extra fields for Espresso
  final _yieldController = TextEditingController();
  final _timeController = TextEditingController();
  
  // Grinder settings
  String _grinderName = 'Other';
  final _grinderValueController = TextEditingController();
  
  int _rating = 4;
  List<Map<String, dynamic>> _pours = [];
  Map<String, double> _sensoryPoints = {
    'bitterness': 3.0,
    'acidity': 3.0,
    'sweetness': 3.0,
    'body': 3.0,
    'intensity': 3.0,
    'aftertaste': 3.0,
  };

  @override
  void initState() {
    super.initState();
    final r = widget.existingRecipe;
    _method = r?.methodKey ?? widget.initialMethod ?? 'V60';
    _recipeType = _isEspresso(_method) ? 'espresso' : 'filter';
    
    if (r != null) {
      _nameController.text = r.name;
      _coffeeController.text = r.coffeeGrams.toString();
      _waterController.text = r.totalWaterMl.toString();
      _tempController.text = r.brewTempC.toString();
      _grindController.text = r.grindNumber.toString();
      _notesController.text = r.notes;
      _rating = r.rating;
      _grinderName = r.grinderName ?? 'Other';
      _grinderValueController.text = _getGrinderValue(r);
      _recipeType = r.recipeType;
      
      if (_recipeType == 'espresso') {
        _yieldController.text = r.totalWaterMl.toString(); // Yield is stored in totalWaterMl
        _timeController.text = r.grindNumber.toString(); // Time is temporarily stored in grindNumber for espresso? 
        // Actually, let's look at how we want to store it. 
        // For now, let's follow the schema but we might need to map it carefully.
      } else {
        _pours = List<Map<String, dynamic>>.from(r.pours);
      }
      if (widget.existingRecipe?.sensoryJson != null) {
        try {
          _sensoryPoints = Map<String, double>.from(
            jsonDecode(widget.existingRecipe!.sensoryJson!).map(
              (k, v) => MapEntry(k, (v as num).toDouble()),
            ),
          );
        } catch (_) {}
      }
    } else {
      _coffeeController.text = _recipeType == 'espresso' ? '18' : '15';
      _waterController.text = _recipeType == 'espresso' ? '36' : '250';
      _tempController.text = '93';
    }
  }

  bool _isEspresso(String method) {
    final m = method.toLowerCase();
    return m.contains('espresso') || m.contains('lever');
  }

  String _getGrinderValue(CustomRecipeDto r) {
    if (r.grinderName == 'Comandante') return r.comandanteClicks.toString();
    if (r.grinderName == 'EK43') return r.ek43Division.toString();
    return r.grindNumber.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _coffeeController.dispose();
    _waterController.dispose();
    _tempController.dispose();
    _grindController.dispose();
    _notesController.dispose();
    _yieldController.dispose();
    _timeController.dispose();
    _grinderValueController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final db = ref.read(databaseProvider);
    final user = ref.read(supabaseProvider).auth.currentUser;
    if (user == null) return;

    final coffee = double.tryParse(_coffeeController.text) ?? 15.0;
    final water = _recipeType == 'espresso' 
        ? (double.tryParse(_yieldController.text) ?? 36.0)
        : (double.tryParse(_waterController.text) ?? 250.0);

    final grinderVal = int.tryParse(_grinderValueController.text) ?? 0;

    final recipe = CustomRecipesCompanion(
      id: Value(widget.existingRecipe?.id ?? const Uuid().v4()),
      userId: Value(user.id),
      lotId: Value(widget.lotId),
      methodKey: Value(_method),
      name: Value(_nameController.text.isEmpty ? 'Recipe' : _nameController.text),
      coffeeGrams: Value(coffee),
      totalWaterMl: Value(water),
      grindNumber: Value(_recipeType == 'espresso' ? (int.tryParse(_timeController.text) ?? 25) : grinderVal),
      comandanteClicks: Value(_grinderName == 'Comandante' ? grinderVal : 0),
      ek43Division: Value(_grinderName == 'EK43' ? grinderVal : 0),
      totalPours: Value(_recipeType == 'espresso' ? 1 : (_pours.isEmpty ? 1 : _pours.length)),
      pourScheduleJson: Value(_recipeType == 'espresso' ? '[]' : jsonEncode(_pours)),
      brewTempC: Value(double.tryParse(_tempController.text) ?? 93.0),
      notes: Value(_notesController.text),
      rating: Value(_rating),
      updatedAt: Value(DateTime.now()),
      createdAt: widget.existingRecipe == null ? Value(DateTime.now()) : const Value.absent(),
      grinderName: Value(_grinderName),
      recipeType: Value(_recipeType),
      sensoryJson: Value(jsonEncode(_sensoryPoints)),
    );

    if (widget.existingRecipe != null) {
      await db.updateCustomRecipe(recipe);
    } else {
      await db.insertCustomRecipe(recipe);
    }
    
    if (mounted) Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isUk = LocaleService.currentLocale == 'uk';
    final designTheme = ref.watch(designThemeProvider);
    final isCoffee = designTheme == AppDesignTheme.coffee;

    if (isCoffee) {
      return DefaultTabController(
        length: 3,
        child: Dialog(
          backgroundColor: const Color(0xFF161412),
          insetPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 12, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (widget.existingRecipe != null 
                        ? (isUk ? 'РЕДАГУВАТИ РЕЦЕПТ' : 'EDIT RECIPE')
                        : (isUk ? 'ДОДАТИ РЕЦЕПТ' : 'ADD RECIPE')
                      ).toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white38, size: 20),
                    ),
                  ],
                ),
              ),
              TabBar(
                indicatorColor: const Color(0xFFC8A96E),
                labelColor: const Color(0xFFC8A96E),
                unselectedLabelColor: Colors.white38,
                labelStyle: GoogleFonts.outfit(fontSize: 12, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: isUk ? 'РЕЦЕПТ' : 'RECIPE'),
                  Tab(text: isUk ? 'ЕКСТРАКЦІЯ' : 'BREW'),
                  Tab(text: isUk ? 'СМАК' : 'SENSORY'),
                ],
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      height: 600, // Fixed height for TabBarView inside scrollable or use separate scrollables
                      child: TabBarView(
                        children: [
                          _buildRecipeTab(isUk),
                          _buildExtractionTab(isUk),
                          _buildSensoryTab(isUk),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: _buildSaveButton(),
              ),
            ],
          ),
        ),
      );
    }

    // NEW GLASS DESIGN (Modern)
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: GlassContainer(
        borderRadius: 32,
        opacity: 0.15,
        blur: 40,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (widget.existingRecipe != null 
                        ? (isUk ? 'РЕДАГУВАТИ РЕЦЕПТ' : 'EDIT RECIPE')
                        : (isUk ? 'ДОДАТИ РЕЦЕПТ' : 'ADD RECIPE')
                      ).toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white38),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Method Selection
                _buildFieldLabel(isUk ? 'МЕТОД' : 'METHOD'),
                DropdownButtonFormField<String>(
                  initialValue: _method,
                  dropdownColor: const Color(0xFF1E1E1E),
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: _inputDecoration(),
                  items: [
                    'V60', 'Chemex', 'Aeropress', 'Espresso', 'Batch Brew', 
                    'French Press', 'Kalita', 'Origami', 'Lever'
                  ].map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _method = val;
                        _recipeType = _isEspresso(val) ? 'espresso' : 'filter';
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Name
                _buildFieldLabel(isUk ? 'НАЗВА' : 'NAME'),
                TextFormField(
                  controller: _nameController,
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: _inputDecoration(hint: isUk ? 'Профіль або дата' : 'Flavor Profile or Date'),
                ),
                const SizedBox(height: 16),

                // Coffee & Water/Yield Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel(isUk ? 'КАВА (г)' : 'COFFEE (g)'),
                          TextFormField(
                            controller: _coffeeController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.outfit(color: Colors.white),
                            decoration: _inputDecoration(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel(_recipeType == 'espresso' 
                            ? (isUk ? 'ВИХІД (г)' : 'YIELD (g)')
                            : (isUk ? 'ВОДА (мл)' : 'WATER (ml)')),
                          TextFormField(
                            controller: _recipeType == 'espresso' ? _yieldController : _waterController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.outfit(color: Colors.white),
                            decoration: _inputDecoration(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Temp & Grind/Time Row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel(isUk ? 'ТЕМП (°C)' : 'TEMP (°C)'),
                          TextFormField(
                            controller: _tempController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.outfit(color: Colors.white),
                            decoration: _inputDecoration(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFieldLabel(_recipeType == 'espresso' 
                            ? (isUk ? 'ЧАС (с)' : 'ПОМЕЛ') 
                            : (isUk ? 'ПОМЕЛ' : 'GRIND')),
                          TextFormField(
                            controller: _recipeType == 'espresso' ? _timeController : _grinderValueController,
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.outfit(color: Colors.white),
                            decoration: _inputDecoration(hint: _recipeType == 'espresso' ? '25-30' : ''),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                if (_recipeType == 'filter') ...[
                  const SizedBox(height: 16),
                  _buildFieldLabel(isUk ? 'МЛИНОК' : 'GRINDER'),
                  DropdownButtonFormField<String>(
                    initialValue: _grinderName,
                    dropdownColor: const Color(0xFF1E1E1E),
                    style: GoogleFonts.outfit(color: Colors.white),
                    decoration: _inputDecoration(),
                    items: ['Other', 'Comandante', 'EK43', 'Fellow Ode', 'Wilfa']
                        .map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                    onChanged: (val) => setState(() => _grinderName = val ?? 'Other'),
                  ),
                ],

                const SizedBox(height: 16),
                
                _buildFieldLabel(isUk ? 'НОТАТКИ' : 'NOTES'),
                TextFormField(
                  controller: _notesController,
                  maxLines: 3,
                  style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
                  decoration: _inputDecoration(hint: isUk ? 'Ваші враження...' : 'Your impressions...'),
                ),
                
                if (_recipeType == 'filter') ...[
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildFieldLabel(isUk ? 'ГРАФІК ВЛИВАНЬ' : 'POUR SCHEDULE'),
                      TextButton.icon(
                        onPressed: () => setState(() {
                          _pours.add({
                            'atMinute': _pours.isEmpty ? 0.0 : (_pours.last['atMinute'] as double) + 0.5,
                            'waterMl': 50,
                            'notes': '',
                          });
                        }),
                        icon: const Icon(Icons.add_circle_outline, size: 16, color: Color(0xFFC8A96E)),
                        label: Text(isUk ? 'ДОДАТИ' : 'ADD', style: const TextStyle(color: Color(0xFFC8A96E), fontSize: 10)),
                      ),
                    ],
                  ),
                  ..._pours.asMap().entries.map((entry) {
                    final i = entry.key;
                    final p = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            child: TextFormField(
                              initialValue: p['atMinute'].toString(),
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                              decoration: _inputDecoration(hint: 'Min'),
                              onChanged: (v) => _pours[i]['atMinute'] = double.tryParse(v) ?? 0.0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              initialValue: p['waterMl'].toString(),
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: Colors.white, fontSize: 13),
                              decoration: _inputDecoration(hint: 'ml'),
                              onChanged: (v) => _pours[i]['waterMl'] = int.tryParse(v) ?? 0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                            onPressed: () => setState(() => _pours.removeAt(i)),
                          ),
                        ],
                      ),
                    );
                  }),
                ],

                const SizedBox(height: 32),
                _buildFieldLabel(isUk ? 'СМАКОВИЙ ПРОФІЛЬ' : 'SENSORY PROFILE'),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: SensoryRadarChart(
                      staticValues: _sensoryPoints,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ..._sensoryPoints.keys.map((key) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            key.toUpperCase(),
                            style: const TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              trackHeight: 2,
                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                              overlayShape: const RoundSliderOverlayShape(overlayRadius: 12),
                            ),
                            child: Slider(
                              value: _sensoryPoints[key]!,
                              min: 1.0,
                              max: 5.0,
                              divisions: 4,
                              activeColor: const Color(0xFFC8A96E),
                              inactiveColor: Colors.white10,
                              onChanged: (v) => setState(() => _sensoryPoints[key] = v),
                            ),
                          ),
                        ),
                        Text(
                          _sensoryPoints[key]!.toInt().toString(),
                          style: const TextStyle(color: Color(0xFFC8A96E), fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ],
                    ),
                  );
                }),

                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isUk ? 'РЕЙТИНГ' : 'RATING',
                      style: GoogleFonts.outfit(
                        color: Colors.white54,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () => setState(() => _rating = index + 1),
                          child: Icon(
                            index < _rating
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: const Color(0xFFC8A96E),
                            size: 28,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8A96E),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      ref.t('save').toUpperCase(),
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeTab(bool isUk) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel(isUk ? 'МЕТОД' : 'METHOD'),
        DropdownButtonFormField<String>(
          initialValue: _method,
          dropdownColor: const Color(0xFF1E1E1E),
          style: GoogleFonts.outfit(color: Colors.white),
          decoration: _inputDecoration(),
          items: [
            'V60', 'Chemex', 'Aeropress', 'Espresso', 'Batch Brew', 
            'French Press', 'Kalita', 'Origami', 'Lever'
          ].map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
          onChanged: (val) {
            if (val != null) {
              setState(() {
                _method = val;
                _recipeType = _isEspresso(val) ? 'espresso' : 'filter';
              });
            }
          },
        ),
        const SizedBox(height: 16),
        _buildFieldLabel(isUk ? 'НАЗВА' : 'NAME'),
        TextFormField(
          controller: _nameController,
          style: GoogleFonts.outfit(color: Colors.white),
          decoration: _inputDecoration(hint: isUk ? 'Профіль або дата' : 'Flavor Profile or Date'),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isUk ? 'РЕЙТИНГ' : 'RATING',
              style: GoogleFonts.outfit(
                color: Colors.white54,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () => setState(() => _rating = index + 1),
                  child: Icon(
                    index < _rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: const Color(0xFFC8A96E),
                    size: 28,
                  ),
                );
              }),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildFieldLabel(isUk ? 'НОТАТКИ' : 'NOTES'),
        TextFormField(
          controller: _notesController,
          maxLines: 3,
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
          decoration: _inputDecoration(hint: isUk ? 'Ваші враження...' : 'Your impressions...'),
        ),
      ],
    );
  }

  Widget _buildExtractionTab(bool isUk) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(isUk ? 'КАВА (г)' : 'COFFEE (g)'),
                    TextFormField(
                      controller: _coffeeController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.outfit(color: Colors.white),
                      decoration: _inputDecoration(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(_recipeType == 'espresso' 
                      ? (isUk ? 'ВИХІД (г)' : 'YIELD (g)')
                      : (isUk ? 'ВОДА (мл)' : 'WATER (ml)')),
                    TextFormField(
                      controller: _recipeType == 'espresso' ? _yieldController : _waterController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.outfit(color: Colors.white),
                      decoration: _inputDecoration(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(isUk ? 'ТЕМП (°C)' : 'TEMP (°C)'),
                    TextFormField(
                      controller: _tempController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.outfit(color: Colors.white),
                      decoration: _inputDecoration(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildFieldLabel(_recipeType == 'espresso' 
                      ? (isUk ? 'ЧАС (с)' : 'ПОМЕЛ') 
                      : (isUk ? 'ПОМЕЛ' : 'GRIND')),
                    TextFormField(
                      controller: _recipeType == 'espresso' ? _timeController : _grinderValueController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.outfit(color: Colors.white),
                      decoration: _inputDecoration(hint: _recipeType == 'espresso' ? '25-30' : ''),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_recipeType == 'filter') ...[
            const SizedBox(height: 16),
            _buildFieldLabel(isUk ? 'МЛИНОК' : 'GRINDER'),
            DropdownButtonFormField<String>(
              initialValue: _grinderName,
              dropdownColor: const Color(0xFF1E1E1E),
              style: GoogleFonts.outfit(color: Colors.white),
              decoration: _inputDecoration(),
              items: ['Other', 'Comandante', 'EK43', 'Fellow Ode', 'Wilfa']
                  .map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
              onChanged: (val) => setState(() => _grinderName = val ?? 'Other'),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFieldLabel(isUk ? 'ГРАФІК ВЛИВАНЬ' : 'POUR SCHEDULE'),
                TextButton.icon(
                  onPressed: () => setState(() {
                    _pours.add({
                      'atMinute': _pours.isEmpty ? 0.0 : (_pours.last['atMinute'] as double) + 0.5,
                      'waterMl': 50,
                      'notes': '',
                    });
                  }),
                  icon: const Icon(Icons.add_circle_outline, size: 16, color: Color(0xFFC8A96E)),
                  label: Text(isUk ? 'ДОДАТИ' : 'ADD', style: const TextStyle(color: Color(0xFFC8A96E), fontSize: 10)),
                ),
              ],
            ),
            ..._pours.asMap().entries.map((entry) {
              final i = entry.key;
              final p = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      child: TextFormField(
                        initialValue: p['atMinute'].toString(),
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: _inputDecoration(hint: 'Min'),
                        onChanged: (v) => _pours[i]['atMinute'] = double.tryParse(v) ?? 0.0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextFormField(
                        initialValue: p['waterMl'].toString(),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: _inputDecoration(hint: 'ml'),
                        onChanged: (v) => _pours[i]['waterMl'] = int.tryParse(v) ?? 0,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent, size: 20),
                      onPressed: () => setState(() => _pours.removeAt(i)),
                    ),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildSensoryTab(bool isUk) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel(isUk ? 'СМАКОВИЙ ПРОФІЛЬ' : 'SENSORY PROFILE'),
          const SizedBox(height: 16),
          Center(
            child: SizedBox(
              height: 180,
              width: 180,
              child: SensoryRadarChart(
                staticValues: _sensoryPoints,
              ),
            ),
          ),
          const SizedBox(height: 24),
          ..._sensoryPoints.keys.map((key) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: Text(
                      key.toUpperCase(),
                      style: const TextStyle(color: Colors.white60, fontSize: 9, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 5),
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                      ),
                      child: Slider(
                        value: _sensoryPoints[key]!,
                        min: 1.0,
                        max: 5.0,
                        divisions: 4,
                        activeColor: const Color(0xFFC8A96E),
                        inactiveColor: Colors.white10,
                        onChanged: (v) => setState(() => _sensoryPoints[key] = v),
                      ),
                    ),
                  ),
                  Text(
                    _sensoryPoints[key]!.toInt().toString(),
                    style: const TextStyle(color: Color(0xFFC8A96E), fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _save,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFC8A96E),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          ref.t('save').toUpperCase(),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        label,
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: const Color(0xFFC8A96E),
          letterSpacing: 1,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({String? hint}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
      filled: true,
      fillColor: Colors.white.withValues(alpha: 0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFC8A96E), width: 1),
      ),
    );
  }
}
